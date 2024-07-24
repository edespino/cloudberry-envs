# Cloudberry Environments

Automated deployment and management of CloudberryDB environments on Google Cloud Platform (GCP) using Terraform and Ansible.

## Overview

This repository contains Terraform configurations and Ansible playbooks for setting up and managing GCP environments for CloudberryDB.

## Directory Structure

```
ansible/
creds/
gcp-rocky9/
gcp-ubuntu24/
scripts/
terraform/
```

## Getting Started

### 1. Clone the repository

``` shell
git clone <repository-url>
cd <repository-directory>
```

### 2. Create a service account

Create a service account in the Google Cloud Console and download the corresponding JSON key file. The service account should have the necessary permissions to provision VMs in your project.

### 3. Copy the JSON key file

Copy the JSON key file into the `creds` directory (to be created by user) and rename it to `${project_id}-srvc.json`, replacing `${project_id}` with your actual GCP project ID.

### 4. Initialize Terraform

``` shell
cd gcp-rocky9 # or gcp-ubuntu24
terraform init
```

### 5. Plan the Terraform deployment

``` shell
terraform plan
```

### 6. Apply the Terraform configuration

``` shell
terraform apply
```

### 7. Configure CloudberryDB

Navigate to the ansible directory and run the following command to configure CloudberryDB:


``` shell
ansible-playbook --inventory ../gcp-rocky9/inventory.ini --private-key=../gcp-rocky9/ssh_keys/id_rsa-VMs playbooks/cloudberry_setup.yml
```

## Environment

* Ansible version: 2.17.1 (installed via Homebrew)
* Operating System: macOS Sonoma 14.5
* Hardware: MacBook Air

## Prerequisites

* [Terraform](https://www.terraform.io/downloads)
* [Google Cloud SDK](https://cloud.google.com/sdk/install)
* [direnv](https://direnv.net/docs/installation.html)
* [jq](https://stedolan.github.io/jq/download/)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* GCP project and credentials

## License

This project is licensed under the Apache License, Version 2.0. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please submit a pull request with your changes and a brief description of what you've added or modified.
