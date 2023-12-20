+++
title = "aws_subnet Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_subnet"
identifier = "inspec/resources/aws/aws_subnet Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_subnet` InSpec audit resource to test properties of a vpc subnet.

For additional information, including details on parameters and properties, see the [AWS documentation on Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_subnet` resource block uses the parameter to select a VPC and a subnet in the VPC.

```ruby
describe aws_subnet(subnet_id: 'subnet-1234567') do
  it { should exist }
end
```

## Parameters

`subnet_id` _(required)_

: This resource accepts a single parameter, the Subnet ID.
  This can be passed either as a string or as a `subnet_id: 'value'` key-value entry in a hash.

## Properties

`subnet_id`
: Provides the ID of the Subnet.

`vpc_id`
: Provides the ID of the VPC the subnet is in.

`availability_zone`
: Provides the Availability Zone of the subnet.

`cidr_block`
: Provides the block of ip addresses specified to the subnet.

`available_ip_address_count`
: Provides the number of available IPv4 addresses on the subnet.

## Examples

**Check availability zone of a subnet.**

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  its('availability_zone') { should eq 'us-east-1c' }
end
```

**Check the number of available IP addresses.**

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  its('available_ip_address_count') { should eq 251 }
end
```

**Test the block of ip addresses specified to the subnet.**

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  its('cidr_block') { should eq '10.0.1.0/24' }
end
```

**Ensure the subnet is in the right VPC.**

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  its('vpc_id') { should eq 'vpc-12345678' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

#### assigning_ipv_6_address_on_creation

Detects if the network interface on the subnet accepts IPv6 addresses.

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  it { should be_assigning_ipv_6_address_on_creation }
end
```

### available

Provides the current state of the subnet.

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  it { should be_available }
end
```

#### default_for_az

Detects if the subnet is the default subnet for the Availability Zone.

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  it { should be_default_for_az }
end
```

#### mapping_public_ip_on_launch

Provides the VPC ID for the subnet.

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  it { should be_mapping_public_ip_on_launch }
end
```

### exist

The `exist` matcher indicates that a subnet exists for the specified vpc.

```ruby
describe aws_subnet(subnet_id: 'subnet-12345678') do
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeSubnetsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
