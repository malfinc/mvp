Setup so we can pull from gcloud's docker registry:

    gcloud components install docker-credential-gcr
    docker-credential-gcr configure-docker
    gcloud iam service-accounts create docker-for-desktop --display-name "Handles all Docker for desktop services"
    gcloud projects add-iam-policy-binding experimental-works --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/iam.serviceAccountTokenCreator
    gcloud projects add-iam-policy-binding experimental-works --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/viewer

Create credentials for the gcloud service account:

    gcloud iam service-accounts keys create ./tmp/gcloud-key.json --iam-account docker-for-desktop@experimental-works.iam.gserviceaccount.com
    kubectl create secret docker-registry gcr-json-key --docker-server=gcr.io --docker-username=_json_key --docker-password="$(cat ./tmp/gcloud-key.json)" --docker-email=docker-for-desktop@experimental-works.iam.gserviceaccount.com

Setup the GCP:

    gcloud projects create --set-as-default experimental-works
    gcloud config set compute/zone us-west1-a
    gcloud config set compute/region us-west1

Setup k8s clusters:

    gcloud services enable container.googleapis.com
    gcloud beta container clusters create blank-cluster-production --enable-cloud-logging --enable-cloud-monitoring --enable-autoupgrade --enable-autoscaling --min-nodes=3 --max-nodes=5 --machine-type=g1-small --scopes=default,compute-rw,storage-rw --database-encryption-key projects/experimental-works/locations/global/keyRings/blank-api-rails/cryptoKeys/application-secrets
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

    gcloud kms keyrings create blank-api-rails --location global --project experimental-works

Create a gcloud key:

    gcloud kms keys create application-secrets --location global --keyring blank-api-rails --purpose encryption --project experimental-works

Give GCloud CloudBuilder permission to decrypt the application-secrets key:

  gcloud kms keys add-iam-policy-binding application-secrets --location global --keyring blank-api-rails --member serviceAccount:760958921243@cloudbuild.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works

Give GCloud GKE permission to decrypt the application-secrets key:

    gcloud kms keys add-iam-policy-binding application-secrets --location global --keyring blank-api-rails --member serviceAccount:service-760958921243@container-engine-robot.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works

Give Docker for Desktop permission to decrypt the application-secrets key:

    gcloud kms keys add-iam-policy-binding application-secrets --location global --keyring blank-api-rails --member serviceAccount:docker-for-desktop@experimental-works.iam.gserviceaccount.com --role roles/cloudkms.cryptoKeyEncrypterDecrypter --project experimental-works

To store a secret environment variable you can:

    cat config/master.key | gcloud kms encrypt --plaintext-file=- --ciphertext-file=- --location global --keyring blank-api-rails --key application-secrets | base64

Run the migrations:

    kubectl apply -f kubernetes/production/jobs/database-migration.yml

I don't know?

    kubectl expose deployment blank-api-rails --name blank-api-rails-production --type LoadBalancer --protocol TCP --port 80 --target-port 3000

Replace all configs

    kubectl replace --force -f kubernetes/development/application.yaml
