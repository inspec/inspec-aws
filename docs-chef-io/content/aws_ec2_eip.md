+++
title = "aws_ec2_eip resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_eip"
identifier = "inspec/resources/aws/aws_ec2_eip resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_eip` InSpec audit resource to test properties of a single specific Elastic IP (EIP).

An Elastic IP (EIP) is uniquely identified by the public IPv4 address, for example `192.0.2.0`.

For additional information, including details on parameters and properties, see the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html).

## Syntax

Ensure that a Public IP exists.

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
  it { should exist }
end
```

## Parameters

`public_ip` _(required)_

## Properties

`public_ip`
: The Elastic IP address, or the carrier IP address.

`instance_id`
: The ID of the instance the address is associated with, if any.

`allocation_id`
: The allocation ID for the address.

`association_id`
: The association ID for the address.

`domain`
: Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc).

`network_interface_id`
: The ID of the network interface that the address is associated with, if any.

`network_interface_owner_id`
: The AWS account ID of the owner.

`private_ip_address`
: The private IP address associated with the Elastic IP address.

`public_ipv_4_pool`
: The Elastic IPV4 pool address.

`network_border_group`
: A unique set of Availability Zones, Local Zones, or Wavelength Zones from where AWS advertises IP addresses.

## Examples

**Ensure a Public IP is available.**

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
  its('public_ip') { should eq '192.0.2.0' }
end
```

**Ensure that the domain is `vpc` or `standard`.**

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
    its('domain') { should eq 'vpc' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_vpc_endpoint(public_ip: '192.0.2.0') do
  it { should_not exist }
end
```

### be_available

Check if the IP address is available.

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
  it { should be_available }
end
```

Use `should_not` to test an IP address that should not exist.

```ruby
describe aws_ec2_eip(public_ip: '192.0.2.0') do
  it { should_not be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeAddressesResult" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
