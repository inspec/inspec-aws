+++
title = "aws_ec2_client_vpn_endpoint resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_client_vpn_endpoint"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_endpoint resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_endpoint` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN endpoint.

The `AWS::EC2::ClientVpnEndpoint` specifies a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 ClientVpnEndpoint.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html).

## Syntax

Ensure that the client VPN endpoint exists.

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint.

## Properties

`client_vpn_endpoint_id`
: The ID of the Client VPN endpoint.

`description`
: A brief description of the endpoint.

`status.code`
: The state of the Client VPN endpoint.

`status.message`
: A message about the status of the Client VPN endpoint.

`creation_time`
: The date and time the Client VPN endpoint was created.

`deletion_time`
: The date and time the Client VPN endpoint was deleted, if applicable.

`dns_name`
: The DNS name to be used by clients when connecting to the Client VPN endpoint.

`client_cidr_block`
: The IPv4 address range, in CIDR notation, from which client IP addresses are assigned.

`dns_servers`
: Information about the DNS servers to be used for DNS resolution.

`split_tunnel`
: Indicates whether split-tunnel is enabled in the Client VPN endpoint.

`vpn_protocol`
: The protocol used by the VPN session.

`transport_protocol`
: The transport protocol used by the Client VPN endpoint.

`vpn_port`
: The port number for the Client VPN endpoint.

`associated_target_networks`
: Information about the associated target networks. A target network is a subnet in a VPC.

`associated_target_network_id`
: The ID of the subnet.

`associated_target_network_type`
: The target network type.

`server_certificate_arn`
: The ARN of the server certificate.

`authentication_options`
: Information about the authentication method used by the Client VPN endpoint.

`authentication_options_types`
: The authentication type used.

`authentication_options_active_directory_ids`
: The ID of the Active Directory used for authentication.

`authentication_options_mutual_authentication.client_root_certificate_chains`
: The ARN of the client certificate.

`authentication_options_federated_authentication_saml_provider_arns`
: The Amazon Resource Name (ARN) of the IAM SAML identity provider.

`authentication_options_federated_authentication_self_service_saml_provider_arns`
: The Amazon Resource Name (ARN) of the IAM SAML identity provider for the self-service portal.

`connection_log_options_enabled`
: Indicates whether client connection logging is enabled for the Client VPN endpoint.

`connection_log_options_cloudwatch_log_groups`
: The name of the Amazon CloudWatch Logs log group to which connection logging data is published.

`connection_log_options_cloudwatch_log_streams`
: The name of the Amazon CloudWatch Logs log stream to which connection logging data is published.

`tags`
: Describes a tag.

`security_group_ids`
: The IDs of the security groups for the target network.

`vpc_id`
: The ID of the VPC.

`self_service_portal_url`
: The URL of the self-service portal.

`client_connect_options_enabled`
: Indicates whether client connect options are enabled.

`client_connect_options_lambda_function_arns`
: The Amazon Resource Name (ARN) of the Lambda function used for connection authorization.

`client_connect_options_status_codes`
: The status code.

`client_connect_options_status_messages`
: The status message.

## Examples

**Ensure a client VPN endpoint ID is available.**

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  its('client_vpn_endpoint_id') { should eq 'CLIENT_VPN_ENDPOINT_ID' }
end
```

**Ensure that the status code is `available`.**

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
    its('status.code') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnEndpointsResult" %}}
