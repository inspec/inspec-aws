+++
title = "aws_ec2_client_vpn_target_network_association resource"

draft = false


[menu.aws]
title = "aws_ec2_client_vpn_target_network_association"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_target_network_association resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_target_network_association` InSpec audit resource to test properties of a single AWS EC2 Client VPN target network association.

The `AWS::EC2::ClientVpnTargetNetworkAssociation` checks if a target network to associated with a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Client VPN target network association.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpntargetnetworkassociation.html).

## Syntax

Ensure that the client VPN target network association exists.

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint.

`association_id` _(required)_

: The ID of the association.

## Properties

`association_id`
: The ID of the association.

`vpc_id`
: The ID of the VPC in which the target network (subnet) is located.

`target_network_id`
: The ID of the subnet specified as the target network.

`client_vpn_endpoint_id`
: The ID of the Client VPN endpoint with which the target network is associated.

`status.code`
: The state of the target network association.

`status.message`
: A message about the status of the target network association, if applicable.

`security_groups`
: The IDs of the security groups applied to the target network association.

## Examples

Ensure an association exists:

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
  its('association_id') { should eq 'ASSOCIATION_ID' }
end
```

Ensure that the status code is `active`:

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
    its('status.code') { should eq 'active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", association_id: "ASSOCIATION_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnTargetNetworksResult" %}}
