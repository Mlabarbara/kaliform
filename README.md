# Kaliform - Terraform Configuration for Kali Linux VMs

This repository contains Terraform configurations for automatically deploying multiple Kali Linux virtual machines on a Proxmox virtualization environment. The setup creates two sets of Kali Linux instances with specific network configurations and hardware allocations.

## Overview

The configuration creates:
- 2 VMs named `kali-linux-21` and `kali-linux-22` on storage `nvme002`
- 2 VMs named `kali-linux-11` and `kali-linux-12` on storage `nvme001`

Each VM is configured with:
- 4 CPU cores
- 6GB RAM
- 90GB SSD storage
- Dual network interfaces
- Cloud-init support
- Hot-plug capabilities for network, disk, USB, and memory

## Prerequisites

- Proxmox Virtual Environment (PVE) server
- Terraform installed (version compatible with provider `telmate/proxmox` 2.9.14)
- A Kali Linux template VM named `template-kalilinux` in your Proxmox environment
- Valid Proxmox API tokens
- SSH key pair for VM access

## Network Configuration

Each VM is configured with two network interfaces:
- Primary Network (vmbr0):
  - First set: 192.168.11.101/16, 192.168.11.102/16
  - Second set: 192.168.11.111/16, 192.168.11.112/16
  - Gateway: 192.168.10.1
- Secondary Network (vmbr1):
  - First set: 10.10.10.101/24, 10.10.10.102/24
  - Second set: 10.10.10.111/24, 10.10.10.112/24

## Required Variables

Create a `terraform.tfvars` file with the following variables:
```hcl
pm_api_url           = "https://your-proxmox-server:8006/api2/json"
pm_api_token_id      = "your-token-id"
pm_api_token_secret  = "your-token-secret"
ssh_key             = "your-ssh-public-key"
```

## Usage

1. Clone this repository
2. Create and populate the `terraform.tfvars` file with your values
3. Initialize Terraform:
```bash
terraform init
```
4. Review the planned changes:
```bash
terraform plan
```
5. Apply the configuration:
```bash
terraform apply
```

## Important Notes

- The configuration assumes a Proxmox node named `r630-pve`
- VM IDs are automatically assigned in the 2001-2002 and 2011-2012 ranges
- All VMs use virtio networking and SCSI disk configuration
- Cloud-init is enabled for initial VM configuration
- TLS verification is disabled for the Proxmox API connection

## Security Considerations

- The `terraform.tfvars` file contains sensitive information and is excluded from version control
- API tokens should have the minimum required permissions
- Consider enabling TLS verification in production environments by setting `pm_tls_insecure = false`

## Maintenance

Remember to:
- Regularly update the Kali Linux template VM
- Monitor disk usage on the nvme001 and nvme002 storage
- Keep Terraform provider versions updated
- Review and update network configurations as needed

## License

[Your license information here]