/**
* Copyright 2024 Google LLC
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

terraform {
  required_providers {
    google = {
      version = "~> 6.49"
    }
    google-beta = {
      version = "~> 6.49"
    }
  }
}
locals {
  # Applied to every resource that supports labels (via provider default_labels)
  # for cost allocation, filtering, and billing reports.
  common_labels = {
    app         = "genmedia-studio"
    environment = var.environment
    team        = var.team
    owner       = var.owner
    cost_center = var.cost_center
  }
}

provider "google" {
  project        = var.project_id
  region         = var.region
  default_labels = local.common_labels
}

provider "google-beta" {
  project        = var.project_id
  region         = var.region
  default_labels = local.common_labels
}

data "google_project" "project" {
  project_id = var.project_id
}

module "apis" {
  source     = "./modules/project-services"
  project_id = var.project_id
  sleep_time = var.sleep_time
}

/********************************************
*  Network Infra Resources Section
*********************************************/

/* There are times when IAP service account is not automatically provisioned, creating explicitly to be sure */
resource "google_project_service_identity" "iap_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "iap.googleapis.com"
}

resource "google_iap_web_iam_member" "initial_user_iap_access" {
  count      = var.use_lb && var.initial_user != null ? 1 : 0
  role       = "roles/iap.httpsResourceAccessor"
  member     = "user:${var.initial_user}"
  depends_on = [module.apis]
}

resource "google_cloud_run_service_iam_member" "iap_cloudrun_access" {
  location = google_cloud_run_v2_service.creative_studio.location
  service  = google_cloud_run_v2_service.creative_studio.name
  role     = "roles/run.invoker"
  member   = google_project_service_identity.iap_sa.member
}

# Reserved (static) global IP for the external load balancer. Managed by
# Terraform so the address is stable across load balancer recreation. When
# var.reserved_ip_address is set, that pre-existing address is used instead.
resource "google_compute_global_address" "lb_ipv4" {
  count      = var.use_lb && var.reserved_ip_address == null ? 1 : 0
  name       = "creativestudio-lb-ip"
  ip_version = "IPV4"
  depends_on = [module.apis]
}

module "lb-http" {
  count                           = var.use_lb ? 1 : 0
  source                          = "terraform-google-modules/lb-http/google//modules/serverless_negs"
  version                         = "~> 14.0"
  name                            = "creativestudio"
  project                         = var.project_id
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  ssl                             = var.use_lb
  managed_ssl_certificate_domains = [var.domain]
  https_redirect                  = var.use_lb
  address                         = coalesce(var.reserved_ip_address, one(google_compute_global_address.lb_ipv4[*].address))
  create_address                  = false
  backends = {
    default = {
      description = "Creative Studio backend"
      protocol    = "HTTPS"
      enable_cdn  = false
      groups = [
        {
          group = google_compute_region_network_endpoint_group.cloudrun_neg[0].id
        }
      ]
      iap_config = {
        enable = true
      }
      log_config = {
        enable = true
      }
    }
  }
  depends_on = [module.apis]
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  count                 = var.use_lb ? 1 : 0
  name                  = "cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.creative_studio.name
  }
  depends_on = [module.apis]
}

/********************************************
*  Runtime Resources Section
*********************************************/

resource "google_service_account" "creative_studio" {
  account_id = "service-creative-studio"
}

module "data" {
  source                   = "./modules/data-stores"
  project_id               = var.project_id
  region                   = var.region
  bucket_name              = local.asset_bucket_name
  cors_domains             = local.cors_domains
  enable_data_deletion     = var.enable_data_deletion
  asset_lifecycle_age_days = var.asset_lifecycle_age_days

  depends_on = [module.apis]
}

resource "google_project_iam_member" "creative_studio_tasks_enqueuer" {
  project = var.project_id
  role    = "roles/cloudtasks.enqueuer"
  member  = google_service_account.creative_studio.member
}

# Centralizing environment variables here and using for each in service declaration for simplicity
locals {
  asset_bucket_name = "creative-studio-${var.project_id}-assets"
  creative_studio_env_vars = {
    PROJECT_ID                            = var.project_id
    LOCATION                              = var.region
    GEMINI_LOCATION                       = var.gemini_location
    GEMINI_TTS_LOCATION                   = var.gemini_tts_location
    MODEL_ID                              = var.model_id
    GEMINI_AUDIO_ANALYSIS_MODEL_ID        = var.gemini_audio_analysis_model_id
    GEMINI_CRITIQUE_MODEL_ID              = var.gemini_critique_model_id
    GEMINI_CRITIQUE_LOCATION              = var.gemini_critique_location
    CHARACTER_CONSISTENCY_GEMINI_LOCATION = var.character_consistency_gemini_location
    VEO_MODEL_ID                          = var.veo_model_id
    VEO_LOCATION                          = coalesce(var.veo_location, var.region)
    VEO_EXP_MODEL_ID                      = var.veo_exp_model_id
    LYRIA_MODEL_VERSION                   = var.lyria_model_id
    LYRIA_PROJECT_ID                      = var.project_id
    GENMEDIA_BUCKET                       = local.asset_bucket_name
    VIDEO_BUCKET                          = local.asset_bucket_name
    MEDIA_BUCKET                          = local.asset_bucket_name
    IMAGE_BUCKET                          = local.asset_bucket_name
    GCS_ASSETS_BUCKET                     = local.asset_bucket_name
    GENMEDIA_FIREBASE_DB                  = module.data.firestore_db_name
    SERVICE_ACCOUNT_EMAIL                 = google_service_account.creative_studio.email
    EDIT_IMAGES_ENABLED                   = var.edit_images_enabled
    THUMBNAIL_QUEUE_ID                    = module.data.tasks_queue_name
    API_BASE_URL                          = var.api_base_url != "" ? var.api_base_url : (var.use_lb ? "https://${var.domain}" : "")
  }

  deployed_domain = var.use_lb ? ["https://${var.domain}"] : google_cloud_run_v2_service.creative_studio.urls
  cors_domains    = concat(local.deployed_domain, var.allow_local_domain_cors_requests ? ["http://localhost:8080", "http://0.0.0.0:8080"] : [])
}

resource "google_cloud_run_v2_service" "creative_studio" {
  provider             = google-beta
  name                 = "creative-studio"
  location             = var.region
  project              = var.project_id
  ingress              = var.use_lb ? "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER" : "INGRESS_TRAFFIC_ALL"
  default_uri_disabled = var.use_lb
  deletion_protection  = false
  iap_enabled          = !var.use_lb
  invoker_iam_disabled = !var.use_lb
  launch_stage         = var.use_lb ? "GA" : "BETA"

  template {
    timeout                          = var.cloud_run_timeout
    max_instance_request_concurrency = var.cloud_run_max_concurrency
    containers {
      name  = "creative-studio"
      image = var.initial_container_image
      resources {
        limits = {
          cpu    = var.cloud_run_cpu
          memory = var.cloud_run_memory
        }
      }
      dynamic "env" {
        for_each = local.creative_studio_env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
    service_account = google_service_account.creative_studio.email
    scaling {
      max_instance_count = 1
    }
  }
  lifecycle {
    ignore_changes = [template[0].containers[0].image, client, client_version]
  }
  depends_on = [
    google_service_account_iam_member.build_act_as_creative_studio,
    google_project_iam_member.build_logs_writer,
    module.apis
  ]
}

/* There are times when Vertex service account is not automatically provisioned, creating explicitly to be sure */
resource "google_project_service_identity" "vertex_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "aiplatform.googleapis.com"
}

resource "google_project_iam_member" "vertex_sa_access" {
  project = var.project_id
  role    = "roles/aiplatform.serviceAgent"
  member  = google_project_service_identity.vertex_sa.member
}

resource "google_storage_bucket_iam_member" "admins" {
  bucket = module.data.assets_bucket_name
  role   = "roles/storage.objectAdmin"
  member = "user:${var.initial_user}"
}

resource "google_storage_bucket_iam_member" "creators" {
  bucket = module.data.assets_bucket_name
  role   = "roles/storage.objectCreator"
  member = google_service_account.creative_studio.member
}

resource "google_storage_bucket_iam_member" "viewers" {
  bucket = module.data.assets_bucket_name
  role   = "roles/storage.objectViewer"
  member = google_service_account.creative_studio.member
}

resource "google_storage_bucket_iam_member" "sa_bucket_viewer" {
  bucket = module.data.assets_bucket_name
  role   = "roles/storage.bucketViewer"
  member = google_service_account.creative_studio.member
}

resource "google_storage_bucket_iam_member" "sa_object_user" {
  bucket = module.data.assets_bucket_name
  role   = "roles/storage.objectUser"
  member = google_service_account.creative_studio.member
}

resource "google_project_iam_member" "creative_studio_sa_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = google_service_account.creative_studio.member
}

resource "google_project_iam_member" "creative_studio_db_access" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = google_service_account.creative_studio.member
  condition {
    title      = "Access to Create Studio Asset Metadata DB"
    expression = "resource.name==\"${module.data.firestore_db_id}\""
  }
}

resource "google_project_iam_member" "creative_studio_vertex_access" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = google_service_account.creative_studio.member
}

/********************************************
*  Build time Resources Section
*********************************************/

resource "google_service_account" "cloudbuild" {
  account_id = "builds-creative-studio"
}

resource "google_service_account_iam_member" "build_act_as_creative_studio" {
  service_account_id = google_service_account.creative_studio.name
  role               = "roles/iam.serviceAccountUser"
  member             = google_service_account.cloudbuild.member
}

resource "google_project_iam_member" "build_logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = google_service_account.cloudbuild.member
}

module "registry" {
  source               = "./modules/artifact-registry"
  project_id           = var.project_id
  region               = var.region
  initial_user         = var.initial_user
  enable_data_deletion = var.enable_data_deletion
  build_sa_member      = google_service_account.cloudbuild.member

  depends_on = [module.apis]
}

resource "google_cloud_run_service_iam_member" "build_service" {
  location = google_cloud_run_v2_service.creative_studio.location
  service  = google_cloud_run_v2_service.creative_studio.name
  role     = "roles/run.developer"
  member   = google_service_account.cloudbuild.member
}
