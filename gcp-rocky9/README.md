
 # GCP Rocky Linux 9 Terraform Configuration

This project sets up a GCP environment using Terraform, including network, instances, and SSH key management.

## Directory Structure

```
gcp-rocky9/
  main.tf
  variables.tf
  providers.tf
  outputs.tf
  custom_exec.tf
  .envrc
  terraform.tfvars
  README.md
terraform/modules/
  network/
  instances/
  ssh_keys/
  README.md
creds/
scripts/
  update_BOOT_IMAGE.sh
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud SDK](https://cloud.google.com/sdk)
- [direnv](https://direnv.net/)
- GCP project and credentials
- [jq](https://stedolan.github.io/jq/)

## Setup

1. **Configure Environment Variables**:
   Ensure you have `.envrc` configured in the `gcp-rocky9` directory.

2. **Enable direnv**:
   Allow direnv to load environment variables.
   ```sh
   direnv allow
   ```

3. **Initialize Terraform**:
   Initialize the Terraform working directory.
   ```sh
   terraform init
   ```

4. **Create a `terraform.tfvars` File**:
   Create a `terraform.tfvars` file in the `gcp-rocky9` directory with the following content:
   ```hcl
   # Number of instances to create
   INSTANCE_COUNT=1

   # Machine type to use for the instances
   MACHINE_TYPE="n4-highmem-8"

   # Note: The BOOT_IMAGE value is retrieved with the following command:
   # gcloud compute images list --filter="name~'rocky-linux-9-optimized-gcp' AND architecture='X86_64'"
   BOOT_IMAGE="https://www.googleapis.com/compute/v1/projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20240717"
   ```

5. **Update the Boot Image**:
   Use the provided `update_boot_image.sh` script in the `scripts` directory to update the `BOOT_IMAGE` value in the `terraform.tfvars` file if necessary.
   ```sh
   ../scripts/update_boot_image.sh
   ```

## Description of `update_boot_image.sh` Script

The `update_boot_image.sh` script automates the process of updating the `BOOT_IMAGE` value in the `terraform.tfvars` file. It performs the following steps:

1. Checks if the `terraform.tfvars` file exists. If not, it prompts the user to create it first.
2. Retrieves the latest `BOOT_IMAGE` using the `gcloud` command and filters by architecture `X86_64`.
3. Compares the current `BOOT_IMAGE` value in `terraform.tfvars` with the latest value.
4. Updates the `BOOT_IMAGE` value in `terraform.tfvars` if there is a change, or informs the user if no update is necessary.

### Usage

1. Ensure `terraform.tfvars` exists in the `gcp-rocky9` directory.
2. Run the script:
   ```sh
   ../scripts/update_boot_image.sh
   ```

6. **Apply the Configuration**:
   Apply the Terraform configuration.
   ```sh
   terraform apply
   ```

## Cleanup

To destroy the created infrastructure:
```sh
terraform destroy
```

## Outputs

The following outputs will be available after applying the configuration:
- `instance_ips`: Public IP addresses of the instances
- `instance_count`: Number of instances created
