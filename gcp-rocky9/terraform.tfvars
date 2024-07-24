# Number of instances to create
instance_count=1

# Machine type to use for the instances
machine_type="n4-highmem-8"

# Note: The boot_image value is retrieved with the following command:
# gcloud compute images list --filter="name~'rocky' AND family='rocky-linux-9-optimized-gcp'"
boot_image="https://www.googleapis.com/compute/v1/projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20240717"
