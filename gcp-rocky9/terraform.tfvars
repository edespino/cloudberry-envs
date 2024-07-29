# Number of instances to create
INSTANCE_COUNT=1

# Machine type to use for the instances
MACHINE_TYPE="n4-highmem-8"

# Note: The boot_image value is retrieved with the following command:
# gcloud compute images list --filter="name~'rocky' AND family='rocky-linux-9-optimized-gcp'"
BOOT_IMAGE="https://www.googleapis.com/compute/v1/projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20240717"
