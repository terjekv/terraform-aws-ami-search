# get amis data from aws
data "aws_ami" "search" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

#  name_regex = "^RHEL-8.*HVM-20.*x86_64.*"
#  owners = ["309956199498"]
  name_regex = local.ami_string
  owners     = [length(var.amis_primary_owners) == 0 ? lookup(local.amis_os_map_owners, var.os) : var.amis_primary_owners]
}
