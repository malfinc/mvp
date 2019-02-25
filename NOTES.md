Setup so we can pull from gcloud's docker registry:

    gcloud components install docker-credential-gcr
    docker-credential-gcr configure-docker
    gcloud iam service-accounts create docker-for-desktop --display-name "Handles all Docker for desktop services"
    gcloud projects add-iam-policy-binding experimental-works --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/iam.serviceAccountTokenCreator
    gcloud projects add-iam-policy-binding experimental-works --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/viewer

Create credentials for the gcloud service account for non-GKE development:

    gcloud iam service-accounts keys create ./tmp/gcloud-key.json --iam-account docker-for-desktop@experimental-works.iam.gserviceaccount.com
    kubectl create secret docker-registry gcr-json-key --docker-server=gcr.io --docker-username=_json_key --docker-password="$(cat ./tmp/gcloud-key.json)" --docker-email=docker-for-desktop@experimental-works.iam.gserviceaccount.com

Setup the GCP:

    gcloud projects create --set-as-default experimental-works
    gcloud config set compute/zone us-west1-a
    gcloud config set compute/region us-west1

Setup k8s clusters:

    gcloud services enable container.googleapis.com
    gcloud beta container clusters create blank-cluster-production --enable-cloud-logging --enable-cloud-monitoring --enable-autoupgrade --enable-autoscaling --min-nodes=3 --max-nodes=5 --machine-type=g1-small --scopes=default,compute-rw,storage-rw --database-encryption-key projects/experimental-works/locations/global/keyRings/blank-api-rails/cryptoKeys/runtime-secrets
    gcloud container clusters get-credentials blank-cluster-production

Setup ip addresses:

    gcloud services enable compute.googleapis.com
    gcloud compute addresses create blank-api-rails-ipv4-address --global --ip-version IPV4
    gcloud compute addresses create blank-api-rails-ipv6-address --global --ip-version IPV6
    gcloud compute addresses list

Then point zone file to those ip addresses.

Setup GCP to handle our docker images:

    gcloud services enable containerregistry.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
    export COMMIT_SHA=$(git rev-parse --verify HEAD)
    gcloud container builds submit --config cloudbuild.yaml --substitutions=COMMIT_SHA=$COMMIT_SHA

Create a gcloud keyring:

    gcloud kms keyrings create runtime-secrets --location global --project experimental-works

Create a gcloud key for every environment variable needing security:

    gcloud kms keys create RAILS_MASTER_KEY --location global --keyring runtime-secrets --purpose encryption --project experimental-works
    gcloud kms keys create POSTGRES_PASSWORD --location global --keyring runtime-secrets --purpose encryption --project experimental-works

Give various service accounts access to these keys:

    gcloud kms keys add-iam-policy-binding RAILS_MASTER_KEY --location global --keyring runtime-secrets --member serviceAccount:760958921243@cloudbuild.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works
    gcloud kms keys add-iam-policy-binding POSTGRES_PASSWORD --location global --keyring runtime-secrets --member serviceAccount:760958921243@cloudbuild.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works
    gcloud kms keys add-iam-policy-binding RAILS_MASTER_KEY --location global --keyring runtime-secrets --member serviceAccount:service-760958921243@container-engine-robot.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works
    gcloud kms keys add-iam-policy-binding POSTGRES_PASSWORD --location global --keyring runtime-secrets --member serviceAccount:service-760958921243@container-engine-robot.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works
    gcloud kms keys add-iam-policy-binding RAILS_MASTER_KEY --location global --keyring runtime-secrets --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works
    gcloud kms keys add-iam-policy-binding POSTGRES_PASSWORD --location global --keyring runtime-secrets --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works

To store a secret environment variable you can:

    cat config/master.key | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --location global --keyring runtime-secrets --key RAILS_MASTER_KEY | base64
    date | md5 | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --location global --keyring runtime-secrets --key POSTGRES_PASSWORD | base64

You'll want to store the result of the above inside cloudbuild's variables list.

This generates a pgbouncer md5 hash for userlists:

    echo "md5$(printf "{{password}}{{username}}" | openssl md5)"
