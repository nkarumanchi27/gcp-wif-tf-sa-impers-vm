#! /bin/bash
export GOOGLE_CLOUD_PROJECT="intense-elysium-446714-g4"
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT="terraform-sa-na@intense-elysium-446714-g4.iam.gserviceaccount.com"
gcloud auth application-default login
gcloud config set project $GOOGLE_CLOUD_PROJECT
gcloud config set auth/impersonate_service_account $GOOGLE_IMPERSONATE_SERVICE_ACCOUNT

echo "Setup Complete. You can run terraform commands now."