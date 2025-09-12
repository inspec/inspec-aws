+++
title = "aws_ec2_client_vpn_target_network_associations resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_client_vpn_target_network_associations"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_target_network_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_target_network_associations` InSpec audit resource to test properties of multiple AWS EC2 Client VPN target network associations.

The `AWS::EC2::ClientVpnTargetNetworkAssociation` specifies a target network to associate with a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 ClientVpnTargetNetworkAssociation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpntargetnetworkassociation.html).

## Syntax

Ensure that the client vpn target network association exists.

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint.

## Properties

`association_ids`
: The ID of the association.

: **Field**: `association_id`

`vpc_ids`
: The ID of the VPC in which the target network (subnet) is located.

: **Field**: `vpc_id`

`target_network_ids`
: The ID of the subnet specified as the target network.

: **Field**: `target_network_id`

`client_vpn_endpoint_ids`
: The ID of the Client VPN endpoint with which the target network is associated.

: **Field**: `client_vpn_endpoint_id`

`status_codes`
: The state of the target network association.

: **Field**: `status.code`

`status_messages`
: A message about the status of the target network association, if applicable.

: **Field**: `status.message`

`security_groups`
: The IDs of the security groups applied to the target network association.

: **Field**: `security_groups`

## Examples

**Ensure an association exists.**

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  its('association_ids') { should include 'ASSOCIATION_ID' }
end
```

**Ensure that the status code is `active`.**

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
    its('status_code') { should include 'active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnTargetNetworksResult" %}}
