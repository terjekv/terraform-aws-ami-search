# AWS AMI SEARCH Terraform module

This terraform module finds the most recent AWS AMI for a specific linux distribution, optionally filtered by version and architecture.  

## Supported distributions:

* amazon (incomplete)
* debian (incomplete)
* fedora (incomplete)
* centos
* ubuntu
* rhel
* rocky
* suse (incomplete)

## Supported architectures

* x86_64
* arm64

For distributions that do not use these exact architecture names, the module will map the name above to the whichever local naming scheme the distribution uses. Ie, if x86_64 is requested as the architecture for debian or one of its derivatives, the module will transparently map this to `amd64`.

## Supported versions

Version support depends wholly on the distribution in question. See [the source code](variables.tf) for details.
## Examples
--------

```hcl
module "ami-search" {
  source  = "terjekv/ami-search/aws"
  os = "rhel"
  os_version = "8" # optional, see variables.tf for defaults
  architecture = "arm64" # optional, defaults to x86_64
}

resource "aws_instance" "web" {
  ami = module.ami-search.ami_id
  instance_type = "t4g.micro"

  tags {
    Name = "HelloWorld"
  }
}
```

## Limitations

* HVM type only (Hardcoded in the filter module)
* Ubuntu only accepts .04-releases.
* The user is responsible for matching the `instance_type` of the instance to the architecture of the ami.
* No windows support as of yet.


## Terraform versions supported

Terraform 0.12 and later.

## Thanks

The [original repo](https://github.com/otassetti/terraform-aws-ami-search) has a PR with compatibility with Terraform >= 0.12 since September 2020 and not accepted. The original author seems not active on Github since 2019.

The [updated repo](https://github.com/DeLoWaN/terraform-aws-ami-search) added support for newer Terraforms.

This rewrite adds generic support for release identifiers and architecture support. 

## Authors

Original module by [Olivier Tassetti]. Updated module by DeLoWaN. This version by Terje Kvernes.

## License

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
