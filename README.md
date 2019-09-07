gcloud auth activate-service-account \
    --key-file ./service-account.json

gcloud compute scp \
    ./service-account.json plasmic:./service-account.json \
    --zone us-central1-f

gcloud compute scp \
    --recurse \
    ./docker-apex plasmic:~/docker-apex \
    --zone us-central1-f

gcloud beta compute \
    --project "plasmic" \
    ssh \
    --zone "us-central1-f" \
    "plasmic"

docker build \
    -t us.gcr.io/plasmic/nvidia-apex \
    .

gcloud docker -- push us.gcr.io/plasmic/nvidia-apex
