+++
title = "aws_ec2_network_interfaces resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_network_interfaces"
identifier = "inspec/resources/aws/aws_ec2_network_interfaces resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_interfaces` InSpec audit resource to test properties of multiple network interfaces in an Amazon EC2 instance for AWS CloudFormation.

The `AWS::EC2::NetworkInterface` resource describes a network interface in an Elastic Compute Cloud (EC2) instance for AWS CloudFormation.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 network interface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html).

## Syntax

Ensure that network interface ID exists.

```ruby
describe aws_ec2_network_interfaces do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`attachments`
: The attachment.

: **Field**: `attachment`

`availability_zones`
: The Availability Zone.

: **Field**: `availability_zone`

`descriptions`
: A description.

: **Field**: `description`

`groups`
: The security group.

: **Field**: `groups`

`interface_types`
: The type of network interface.

: **Field**: `interface_type`

`ipv_6_addresses`
: The IPv6 address.

: **Field**: `ipv_6_addresses`

`mac_addresses`
: The MAC address.

: **Field**: `mac_address`

`network_interface_ids`
: The ID of the network interface.

: **Field**: `network_interface_id`

`outpost_arns`
: The Amazon Resource Name (ARN) of the Outpost.

: **Field**: `outpost_arn`

`owner_ids`
: The Amazon Web Services account ID of the owner of the network interface.

: **Field**: `owner_id`

`private_dns_names`
: The private DNS name.

: **Field**: `private_dns_name`

`private_ip_addresses`
: The IPv4 address of the network interface within the subnet.

: **Field**: `private_ip_address`

`ipv_4_prefixes`
: The IPv4 Prefix Delegation prefixes that are assigned to the network interface.

: **Field**: `ipv_4_prefixes`

`ipv_6_prefixes`
: The IPv6 Prefix Delegation prefixes that are assigned to the network interface. The IPv6 Prefix Delegation prefix.

: **Field**: `ipv_6_prefixes`

`requester_ids`
: The alias or Amazon Web Services account ID of the principal or service that created the network interface.

: **Field**: `requester_id`

`requester_managed`
: Indicates whether the network interface is being managed by Amazon Web Services.

: **Field**: `requester_managed`

`source_dest_checks`
: Indicates whether source/destination checking is enabled.

: **Field**: `source_dest_check`

`statuses`
: The status of the network interface.

: **Field**: `status`

`subnet_ids`
: The ID of the subnet.

: **Field**: `subnet_id`

`tag_sets`
: Any tags assigned to the network interface.

: **Field**: `tag_set`

`vpc_ids`
: The ID of the VPC.

: **Field**: `vpc_id`

## Examples

**Ensure a network interface ID is available.**

```ruby
describe aws_ec2_network_interfaces do
  its('network_interface_ids') { should include 'NetworkInterfaceId' }
end
```

**Ensure that an availability zone is available.**

```ruby
describe aws_ec2_network_interfaces do
    its('availability_zones') { should include "us-east-2a" }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_interfaces do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_interfaces do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInterfacesResult" %}}
