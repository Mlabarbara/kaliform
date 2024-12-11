terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# use proxmox provider

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "kali2" {
  count = 2
  name = "kali-linux-2${count.index + 1}"
  target_node = "r630-pve"
  vmid = "200${count.index + 1}"
  
  # what VM are we using for the template/master 
  clone = "template-kalilinux"

  # VM type, CPU, memory
  agent = 1
  os_type = "cloud-init"
  cores = 4 
  sockets = 1
  memory = 6144
  balloon = 1
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"
  hotplug = "network,disk,usb,memory"
  numa = true

  disk {
#    slot = 0
    type = "scsi"
    storage = "nvme002"
    iothread = 1
    discard = "on"
    size = "90G"
    ssd = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  network {
    model = "virtio"
    bridge = "vmbr1"
  }

  ipconfig0 = "ip=192.168.11.10${count.index + 1}/16,gw=192.168.10.1"
  ipconfig1 = "ip=10.10.10.10${count.index + 1}/24"
  sshkeys = var.ssh_key
}

resource "proxmox_vm_qemu" "kali1" {
  count = 2
  name = "kali-linux-1${count.index + 1}"
  target_node = "r630-pve"
  vmid = "201${count.index + 1}"
  
  # what VM are we using for the template/master 
  clone = "template-kalilinux"

  # VM type, CPU, memory
  agent = 1
  os_type = "cloud-init"
  cores = 4 
  sockets = 1
  memory = 6144
  balloon = 1
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"
  hotplug = "network,disk,usb,memory"
  numa = true

  disk {
#    slot = 0
    type = "scsi"
    storage = "nvme001"
    iothread = 1
    discard = "on"
    size = "90G"
    ssd = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  network {
    model = "virtio"
    bridge = "vmbr1"
  }

  ipconfig0 = "ip=192.168.11.11${count.index +1}/16,gw=192.168.10.1"
  ipconfig1 = "ip=10.10.10.11${count.index + 1}/24"
  sshkeys = var.ssh_key
}