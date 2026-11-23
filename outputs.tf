output "amazon_linux_public_ip" {
  description = "Public IP address of the Amazon Linux instance."
  value       = module.amazon_linux_server.public_ip
}

output "windows_public_ip" {
  description = "Public IP address of the Windows instance."
  value       = module.windows_server.public_ip
}

output "amazon_linux_private_ip" {
  description = "Private IP address of the Amazon Linux instance."
  value       = module.amazon_linux_server.private_ip
}

output "windows_private_ip" {
  description = "Private IP address of the Windows instance."
  value       = module.windows_server.private_ip
}
