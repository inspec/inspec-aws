+++
title = "aws_ec2_vpc_peering_connection resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_vpc_peering_connection"
identifier = "inspec/resources/aws/aws_ec2_vpc_peering_connection resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_vpc_peering_connection` InSpec audit resource to test properties of a single specific AWS EC2 VPC Peering Connection.

The AWS::EC2::VPCPeeringConnection resource requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 VPC Peering Connection.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html).

## Syntax

Ensure that VPC Peering Connection ID exists.

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
  it { should exist }
end
```

## Parameters

`vpc_peering_connection_id` _(required)_

: The ID of the VPC peering connection.

## Properties

`accepter_vpc_info.cidr_block`
: The IPv4 CIDR block for the VPC.

: **Field**: `accepter_vpc_info.cidr_block`

`accepter_vpc_info.ipv_6_cidr_block_set`
: The IPv6 CIDR block for the VPC.

: **Field**: `accepter_vpc_info.ipv_6_cidr_block_set`

`accepter_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block`
: The IPv6 CIDR block.

: **Field**: `accepter_vpc_info.ipv_6_cidr_block_set[0].ipv_6_cidr_block`

`accepter_vpc_info.cidr_block_set`
: The IPv4 CIDR block for the VPC.

: **Field**: `accepter_vpc_info.cidr_block_set`

`accepter_vpc_info.cidr_block_set.first.cidr_block`
: The IPv4 CIDR block.

: **Field**: `accepter_vpc_info.cidr_block_set[0].cidr_block`

`accepter_vpc_info.owner_id`
: The ID of the Amazon Web Services account that owns the VPC.

: **Field**: `accepter_vpc_info.owner_id`

`accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc`
: Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC.

: **Field**: `accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc`

`accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc`
: Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection.

: **Field**: `accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc`

`accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link`
: Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection.

: **Field**: `accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link`

`accepter_vpc_info.vpc_id`
: The ID of the VPC.

: **Field**: `accepter_vpc_info.vpc_id`

`accepter_vpc_info.region`
: The Region in which the VPC is located.

: **Field**: `accepter_vpc_info.region`

`expiration_time`
: The time that an unaccepted VPC peering connection will expire.

: **Field**: `expiration_time`

`requester_vpc_info.cidr_block`
: The IPv4 CIDR block for the VPC.

: **Field**: `requester_vpc_info.cidr_block`

`requester_vpc_info.ipv_6_cidr_block_set`
: The IPv6 CIDR block for the VPC.

: **Field**: `requester_vpc_info.ipv_6_cidr_block_set`

`requester_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block`
: The IPv6 CIDR block.

: **Field**: `requester_vpc_info.ipv_6_cidr_block_set[0].ipv_6_cidr_block`

`requester_vpc_info.cidr_block_set`
: The IPv4 CIDR block for the VPC.

: **Field**: `requester_vpc_info.cidr_block_set`

`requester_vpc_info.cidr_block_set.first.cidr_block`
: The IPv4 CIDR block.

: **Field**: `requester_vpc_info.cidr_block_set[0].cidr_block`

`requester_vpc_info.owner_id`
: The ID of the Amazon Web Services account that owns the VPC.

: **Field**: `requester_vpc_info.owner_id`

`requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc`
: Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC.

: **Field**: `requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc`

`requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc`
: Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection.

: **Field**: `requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc`

`requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link`
: Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection.

: **Field**: `requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link`

`requester_vpc_info.vpc_id`
: The ID of the VPC.

: **Field**: `requester_vpc_info.vpc_id`

`requester_vpc_info.region`
: The Region in which the VPC is located.

: **Field**: `requester_vpc_info.region`

`status.code`
: The status of the VPC peering connection.

: **Field**: `status.code`

`status.message`
: A message that provides more information about the status, if applicable.

: **Field**: `status.message`

`tags`
: Any tags assigned to the resource.

: **Field**: `tags`

`vpc_peering_connection_id`
: The ID of the VPC peering connection.

: **Field**: `vpc_peering_connection_id`

## Examples

**Ensure a VPC Peering Connection ID is available.**

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
  its('vpc_peering_connection_id') { should eq 'VPCPeeringConnectionID' }
end
```

**Ensure that the status is `available`.**

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
    its('status.code') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcPeeringConnectionsResult" %}}
