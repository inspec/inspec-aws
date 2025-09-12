+++
title = "aws_ec2_client_vpn_authorization_rules resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_client_vpn_authorization_rules"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_authorization_rules resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_authorization_rules` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN authorization rule.

The AWS::EC2::ClientVpnAuthorizationRule specifies an ingress authorization rule to add to a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Client VPN authorization rule.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnauthorizationrule.html).

## Syntax

Ensure that the client VPN endpoint association rule exists.

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint.

## Properties

`client_vpn_endpoint_ids`
: The ID of the Client VPN endpoint with which the authorization rule is associated.

: **Field**: `client_vpn_endpoint_id`

`descriptions`
: A brief description of the authorization rule.

: **Field**: `description`

`group_ids`
: The ID of the Active Directory group to which the authorization rule grants access.

: **Field**: `group_id`

`access_all`
: Indicates whether the authorization rule grants access to all clients.

: **Field**: `access_all`

`destination_cidrs`
: The IPv4 address range, in CIDR notation, of the network to which the authorization rule applies.

: **Field**: `destination_cidr`

`status_codes`
: The status of the authorization rule.

: **Field**: `status_code`

`status_messages`
: A message about the status of the authorization rule, if applicable.

: **Field**: `status_message`

## Examples

Ensure a client VPN endpoint ID is available:

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
  its('client_vpn_endpoint_ids') { should include 'CLIENT_VPN_ENDPOINT_ID' }
end
```

Ensure that the status code is `active`:

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
    its('status_codes') { should include 'active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnAuthorizationRulesResult" %}}
