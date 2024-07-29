# Number of instances to create
INSTANCE_COUNT=1

# Machine type to use for the instances
MACHINE_TYPE="n4-highmem-8"

# Note: The boot_image value is retrieved with the following command:
# gcloud compute images list --filter="name = ubuntu-minimal-2404-noble-amd64 AND family != arm64"
BOOT_IMAGE="https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2404-noble-amd64-v20240727"
