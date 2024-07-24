#!/bin/bash

# Set options for error handling and debugging
set -euo pipefail

# Check if the filter is provided as a command-line argument
if [ -n "${1-}" ]; then
  FILTER="$1"
elif [ -n "${BOOT_IMAGE_FILTER-}" ]; then
  FILTER="$BOOT_IMAGE_FILTER"
else
  echo "Usage: $0 <filter>"
  echo "Or set BOOT_IMAGE_FILTER in .envrc"
  echo "Example filters:"
  echo "  'name~\"rocky-linux-9-optimized-gcp\" AND architecture=\"X86_64\"'"
  echo "  'name = \"ubuntu-minimal-2404-noble-amd64\" AND family != \"arm64\"'"
  exit 1
fi

# Check if terraform.tfvars file exists
if [ ! -f terraform.tfvars ]; then
  echo "terraform.tfvars file does not exist. Please create it first."
  exit 1
fi

# Retrieve the latest boot_image in JSON format with the provided filter
latest_boot_image_json=$(gcloud compute images list --filter="$FILTER" --format="json")

# Extract the selfLink of the latest image
latest_boot_image=$(echo "$latest_boot_image_json" | jq -r '.[0].selfLink')

# Check if the boot_image was retrieved successfully
if [ -z "$latest_boot_image" ]; then
  echo "Failed to retrieve the latest boot_image."
  exit 1
fi

# Read the current boot_image value from terraform.tfvars
current_boot_image=$(grep -E '^boot_image\s*=\s*".*"$' terraform.tfvars | sed 's/boot_image\s*=\s*"\(.*\)"/\1/')

# Compare the current and latest boot_image values
if [ "$current_boot_image" == "$latest_boot_image" ]; then
  echo "No change in boot_image. Skipping update."
else
  # Update the boot_image value in terraform.tfvars using a temporary file for portability
  sed "s|^boot_image\s*=.*|boot_image=\"$latest_boot_image\"|" terraform.tfvars > temp.tfvars
  mv temp.tfvars terraform.tfvars
  echo "terraform.tfvars has been updated with the latest boot_image."
fi
