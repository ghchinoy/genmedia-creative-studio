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

# moved{} blocks: preserve state by telling Terraform these are address moves
# (module encapsulation), NOT destroy/create. Behavior-preserving refactor.

# --- project-services module ---
moved {
  from = module.project-services
  to   = module.apis.module.project_services
}

moved {
  from = null_resource.sleep
  to   = module.apis.null_resource.sleep
}

# --- data-stores module ---
moved {
  from = google_cloud_tasks_queue.thumbnail_queue
  to   = module.data.google_cloud_tasks_queue.thumbnail_queue
}

moved {
  from = google_storage_bucket.assets
  to   = module.data.google_storage_bucket.assets
}

moved {
  from = google_firestore_database.create_studio_asset_metadata
  to   = module.data.google_firestore_database.create_studio_asset_metadata
}

moved {
  from = google_firestore_index.genmedia_library_mime_type_timestamp
  to   = module.data.google_firestore_index.genmedia_library_mime_type_timestamp
}

moved {
  from = google_firestore_index.genmedia_chooser_media_type_timestamp
  to   = module.data.google_firestore_index.genmedia_chooser_media_type_timestamp
}

moved {
  from = google_firestore_index.genmedia_user_email_timestamp
  to   = module.data.google_firestore_index.genmedia_user_email_timestamp
}

moved {
  from = google_firestore_index.genmedia_user_email_mime_type_timestamp
  to   = module.data.google_firestore_index.genmedia_user_email_mime_type_timestamp
}
