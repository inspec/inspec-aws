+++
title = "aws_ec2_client_vpn_endpoints resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_client_vpn_endpoints"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_endpoints resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_endpoints` InSpec audit resource to test properties of multiple AWS EC2 Client VPN endpoint.

The `AWS::EC2::ClientVpnEndpoint` specifies a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 ClientVpnEndpoint.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html).

## Syntax

Ensure that the client VPN endpoint exists.

```ruby
describe aws_ec2_client_vpn_endpoints do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`client_vpn_endpoint_ids`
: The ID of the Client VPN endpoint.

: **Field**: `client_vpn_endpoint_id`

`descriptions`
: A brief description of the endpoint.

: **Field**: `description`

`status_codes`
: The state of the Client VPN endpoint.

: **Field**: `status.code`

`status_messages`
: A message about the status of the Client VPN endpoint.

: **Field**: `status.message`

`creation_times`
: The date and time the Client VPN endpoint was created.

: **Field**: `creation_time`

`deletion_times`
: The date and time the Client VPN endpoint was deleted, if applicable.

: **Field**: `deletion_time`

`dns_names`
: The DNS name to be used by clients when connecting to the Client VPN endpoint.

: **Field**: `dns_name`

`client_cidr_blocks`
: The IPv4 address range, in CIDR notation, from which client IP addresses are assigned.

: **Field**: `client_cidr_block`

`dns_servers`
: Information about the DNS servers to be used for DNS resolution.

: **Field**: `dns_servers`

`split_tunnels`
: Indicates whether split-tunnel is enabled in the Client VPN endpoint.

: **Field**: `split_tunnel`

`vpn_protocols`
: The protocol used by the VPN session.

: **Field**: `vpn_protocol`

`transport_protocols`
: The transport protocol used by the Client VPN endpoint.

: **Field**: `transport_protocol`

`vpn_ports`
: The port number for the Client VPN endpoint.

: **Field**: `vpn_port`

`associated_target_networks`
: Information about the associated target networks. A target network is a subnet in a VPC.

: **Field**: `associated_target_networks`

`associated_target_network_id`
: The ID of the subnet.

: **Field**: `network_id`

`associated_target_network_type`
: The target network type.

: **Field**: `network_type`

`server_certificate_arns`
: The ARN of the server certificate.

: **Field**: `server_certificate_arn`

`authentication_options`
: Information about the authentication method used by the Client VPN endpoint.

: **Field**: `authentication_options`

`authentication_options_types`
: The authentication type used.

: **Field**: `type`

`authentication_options_active_directory_ids`
: The ID of the Active Directory used for authentication.

: **Field**: `directory_id`

`authentication_options_mutual_authentication.client_root_certificate_chains`
: The ARN of the client certificate.

: **Field**: `client_root_certificate_chain`

`authentication_options_federated_authentication_saml_provider_arns`
: The Amazon Resource Name (ARN) of the IAM SAML identity provider.

: **Field**: `saml_provider_arn`

`authentication_options_federated_authentication_self_service_saml_provider_arns`
: The Amazon Resource Name (ARN) of the IAM SAML identity provider for the self-service portal.

: **Field**: `self_service_saml_provider_arn`

`connection_log_options_enabled`
: Indicates whether client connection logging is enabled for the Client VPN endpoint.

: **Field**: `enabled`

`connection_log_options_cloudwatch_log_groups`
: The name of the Amazon CloudWatch Logs log group to which connection logging data is published.

: **Field**: `cloudwatch_log_group`

`connection_log_options_cloudwatch_log_streams`
: The name of the Amazon CloudWatch Logs log stream to which connection logging data is published.

: **Field**: `cloudwatch_log_stream`

`tags`
: Describes a tag.

: **Field**: `tags`

`security_group_ids`
: The IDs of the security groups for the target network.

: **Field**: `security_group_ids`

`vpc_id`
: The ID of the VPC.

: **Field**: `vpc_id`

`self_service_portal_url`
: The URL of the self-service portal.

: **Field**: `self_service_portal_url`

`client_connect_options_enabled`
: Indicates whether client connect options are enabled.

: **Field**: `enabled`

`client_connect_options_lambda_function_arns`
: The Amazon Resource Name (ARN) of the Lambda function used for connection authorization.

: **Field**: `lambda_function_arn`

`client_connect_options_status_codes`
: The status code.

: **Field**: `status.code`

`client_connect_options_status_messages`
: The status message.

: **Field**: `status.message`

## Examples

Ensure a client VPN endpoint ID is available:

```ruby
describe aws_ec2_client_vpn_endpoints do
  its('client_vpn_endpoint_ids') { should include 'CLIENT_VPN_ENDPOINT_ID' }
end
```

Ensure that the status code is `available`:

```ruby
describe aws_ec2_client_vpn_endpoints do
    its('status_codes') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_endpoints do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_endpoints do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_endpoints do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnEndpointsResult" %}}
