output "ami_search_string" {
  description = "The AMI search string used to find the AMI."
  value       = local.ami_string
}

output "ami_id" {
  description = "The AMI id result of the search"
  value       = data.aws_ami.search.id
}

output "ami_name" {
  description = "The AMI name result of the search"
  value       = data.aws_ami.search.name
}

output "user_name" {
  description = "The user name for the AMI"
  value       = local.os_user_names[var.os]
}

output "ami" {
  description = "The full AMI object as a result of the search"
  value       = data.aws_ami.search
}


output "root_device_name" {
  description = "The device name of the root dev"
  value       = data.aws_ami.search.root_device_name
}

output "owner_id" {
  description = "The owner id of the selected ami"
  value       = data.aws_ami.search.owner_id
}
