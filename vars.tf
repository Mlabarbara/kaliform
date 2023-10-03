variable "pm_api_url" {
  description = "API URL for the Proxmox Server"
}
variable "pm_api_token_id" {
  description = "Token ID for the proxmox server user"
}
variable "pm_api_token_secret" {
  description = "Tokem seceret for the token ID"
}
variable "ssh_key" {
  description = "SSH public key for user root for the proxmox server"
}
