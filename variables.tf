locals {
  amis_os_map_owners = {
    "rocky"                = "679593333241",
    "ubuntu"               = "099720109477", #CANONICAL
    "rhel"                 = "309956199498", #Amazon Web Services
    "centos"               = "679593333241",
    "debian"               = "679593333241",
    "fedora"               = "125523088429", #Fedora
    "amazon"               = "137112412989", #amazon
    "suse-les"             = "013907871322", #amazon
    "windows"              = "801119661308", #amazon
  }

  os_arch_map = {
    debian = {
      "x86_64" = "amd64",
      "arm64" = "arm64",
    },
    redhat  = {
      "x86_64" = "x86_64",
      "arm64" = "arm64",
    }
    rocky = {
      "x86_64" = "x86_64",
      "arm64" = "aarch64",
    }
  }

  default_versions = {
    "rhel" = "8",
    "rocky" = "8",
    "centos" = "8",
    "rocky" = "8",
    "ubuntu" = "22",
    "debian" = "11",
    "suse" = "12",
  }

# Rocky-8-ec2-8.5-20211114.2.x86_64-d6577ceb-8ea8-4e0e-84c6-f098fc302e82
# Rocky Linux 8.4 aarch64-8442d1b8-f10f-46f6-8440-d8f7dc722e7d
# ami-0113ad83a378af551
# ami-05b44291810dff0b2

  release = var.os_version == "" ? local.default_versions[var.os] : var.os_version
  ami_strings = {
    "centos" =  "^CentOS.Linux.${local.release}.${local.os_arch_map["redhat"][var.architecture]}.*",
    "rocky" =  "^Rocky.*${local.release}.*${local.os_arch_map["rocky"][var.architecture]}.*",
    "rhel" = "^RHEL-${local.release}.*HVM-20.*${local.os_arch_map["redhat"][var.architecture]}.*",
    "ubuntu" = "^ubuntu/images/hvm-ssd/ubuntu-.*${local.release}.04-.*${local.os_arch_map["debian"][var.architecture]}-server.*",
  }

  ami_string = local.ami_strings[var.os]
}

variable "os" {
  description = "The operating system desired."
  validation {
      condition = contains(["amazon", "debian", "centos", "fedora", "rhel", "rocky", "suse", "ubuntu"], var.os)
      error_message = "Unsupported operating system requested, valid values are: amazon, debian, centos, fedora, rhel, rocky, suse, and ubuntu."
  }
}

variable "os_version" {
  description = "The desired version for the OS."
  default = ""
}
variable "architecture" {
  default = "x86_64"
  description = "The architecture (x86_64 or arm64) for the image."
  validation {
      condition = contains(["x86_64", "arm64"], var.architecture)
      error_message = "Allowed values for architecture is 'x86_64' and 'arm64'."
  }
}

variable "amis_primary_owners" {
  description = "Force the ami Owner, could be (self) or specific (id)"
  default     = ""
}

# variable "amis_os_map_regex" {
#   description = "Map of regex to search amis"
#   type        = map(string)

#   default = {
#     "ubuntu"               = "^ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-14.04"         = "^ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-16.04"         = "^ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-18.04"         = "^ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-19.04"         = "^ubuntu/images/hvm-ssd/ubuntu-disco-19.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-20.04"         = "^ubuntu/images/hvm-ssd/ubuntu-focal-20.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "ubuntu-22.04"         = "^ubuntu/images/hvm-ssd/ubuntu-disco-19.04-${lookup(local["debian_os_arch_map"],var.architecture)}-server-.*"
#     "centos"               = "^CentOS.Linux.7.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "centos-6"             = "^CentOS.Linux.6.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "centos-7"             = "^CentOS.Linux.7.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "centos-8"             = "^CentOS.Linux.8.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "rhel"                 = "^RHEL-7.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "rhel-6"               = "^RHEL-6.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "rhel-7"               = "^RHEL-7.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "rhel-8"               = "^RHEL-8.*${lookup(local["os_arch_map"],"redhat")}.*"
#     "debian"               = "^debian-stretch-.*"
#     "debian-8"             = "^debian-jessie-.*"
#     "debian-9"             = "^debian-stretch-.*"
#     "debian-10"            = "^debian-10-.*"
#     "fedora-27"            = "^Fedora-Cloud-Base-27-.*-gp2.*"
#     "amazon"               = "^amzn-ami-hvm-.*x86_64-gp2"
#     "amazon-2_lts"         = "^amzn2-ami-hvm-.*x86_64-gp2"
#     "suse-les"             = "^suse-sles-12-sp\\d-v\\d{8}-hvm-ssd-x86_64"
#     "suse-les-12"          = "^suse-sles-12-sp\\d-v\\d{8}-hvm-ssd-x86_64"
#     "windows"              = "^Windows_Server-2019-English-Full-Base-.*"
#     "windows-2019-base"    = "^Windows_Server-2019-English-Full-Base-.*"
#     "windows-2016-base"    = "^Windows_Server-2016-English-Full-Base-.*"
#     "windows-2012-r2-base" = "^Windows_Server-2012-R2_RTM-English-64Bit-Base-.*"
#     "windows-2012-base"    = "^Windows_Server-2012-RTM-English-64Bit-Base-.*"
#     "windows-2008-r2-base" = "^Windows_Server-2008-R2_SP1-English-64Bit-Base-.*"
#   }
# }

