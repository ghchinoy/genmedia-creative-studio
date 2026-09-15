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

module "networking-lb" {
  count               = var.use_lb ? 1 : 0
  source              = "./modules/networking-lb"
  project_id          = var.project_id
  region              = var.region
  domain              = var.domain
  reserved_ip_address = var.reserved_ip_address
  service_name        = google_cloud_run_v2_service.creative_studio.name
  enable_iap          = true

  depends_on = [module.apis]
}

/********************************************
*  Runtime Resources Section
*********************************************/

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

module "iam" {
  source             = "./modules/iam"
  project_id         = var.project_id
  firestore_db_id    = module.data.firestore_db_id
  assets_bucket_name = module.data.assets_bucket_name
  initial_user       = var.initial_user
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
    SERVICE_ACCOUNT_EMAIL                 = module.iam.runtime_sa_email
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
    service_account = module.iam.runtime_sa_email
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

/********************************************
*  Build time Resources Section
*********************************************/

# These build-SA bindings stay in the root (not the iam module): the Cloud Run
# resource depends_on them directly, and build_service references the Cloud Run
# service. Keeping them at root preserves those as granular dependencies and
# avoids a module-level cycle. They consume the SA identities from module.iam.
resource "google_service_account_iam_member" "build_act_as_creative_studio" {
  service_account_id = module.iam.runtime_sa_name
  role               = "roles/iam.serviceAccountUser"
  member             = module.iam.build_sa_member
}

resource "google_project_iam_member" "build_logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = module.iam.build_sa_member
}

module "registry" {
  source               = "./modules/artifact-registry"
  project_id           = var.project_id
  region               = var.region
  initial_user         = var.initial_user
  enable_data_deletion = var.enable_data_deletion
  build_sa_member      = module.iam.build_sa_member

  depends_on = [module.apis]
}

resource "google_cloud_run_service_iam_member" "build_service" {
  location = google_cloud_run_v2_service.creative_studio.location
  service  = google_cloud_run_v2_service.creative_studio.name
  role     = "roles/run.developer"
  member   = module.iam.build_sa_member
}
