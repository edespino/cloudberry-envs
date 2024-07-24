# Number of instances to create
instance_count=1

# Machine type to use for the instances
machine_type="n4-highmem-8"

# Note: The boot_image value is retrieved with the following command:
# gcloud compute images list --filter="name = ubuntu-minimal-2404-noble-amd64 AND family != arm64"
boot_image="https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2404-noble-amd64-v20240717"
