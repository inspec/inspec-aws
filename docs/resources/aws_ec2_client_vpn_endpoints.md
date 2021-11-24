---
title: About the aws_ec2_client_vpn_endpoints Resource
platform: aws
---

# aws_ec2_client_vpn_endpoints

Use the `aws_ec2_client_vpn_endpoints` InSpec audit resource to test properties of multiple AWS EC2 Client VPN endpoint.

The `AWS::EC2::ClientVpnEndpoint` specifies a Client VPN endpoint.

## Syntax

Ensure that the client VPN endpoint exists.

    describe aws_ec2_client_vpn_endpoints do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 ClientVpnEndpoint.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| client_vpn_endpoint_ids | The ID of the Client VPN endpoint. | client_vpn_endpoint_id |
| descriptions | A brief description of the endpoint. | description |
| status_codes | The state of the Client VPN endpoint. | status.code |
| status_messages | A message about the status of the Client VPN endpoint. | status.message |
| creation_times | The date and time the Client VPN endpoint was created. | creation_time |
| deletion_times | The date and time the Client VPN endpoint was deleted, if applicable. | deletion_time |
| dns_names | The DNS name to be used by clients when connecting to the Client VPN endpoint. | dns_name |
| client_cidr_blocks | The IPv4 address range, in CIDR notation, from which client IP addresses are assigned. | client_cidr_block |
| dns_servers | Information about the DNS servers to be used for DNS resolution. | dns_servers |
| split_tunnels | Indicates whether split-tunnel is enabled in the Client VPN endpoint. | split_tunnel |
| vpn_protocols | The protocol used by the VPN session. | vpn_protocol |
| transport_protocols | The transport protocol used by the Client VPN endpoint. | transport_protocol |
| vpn_ports | The port number for the Client VPN endpoint. | vpn_port |
| associated_target_networks | Information about the associated target networks. A target network is a subnet in a VPC. | associated_target_networks |
| associated_target_network_id | The ID of the subnet. | network_id |
| associated_target_network_type | The target network type. | network_type |
| server_certificate_arns | The ARN of the server certificate. | server_certificate_arn |
| authentication_options | Information about the authentication method used by the Client VPN endpoint. | authentication_options |
| authentication_options_types | The authentication type used. | type |
| authentication_options_active_directory_ids | The ID of the Active Directory used for authentication. | directory_id |
| authentication_options_mutual_authentication.client_root_certificate_chains | The ARN of the client certificate. | client_root_certificate_chain |
| authentication_options_federated_authentication_saml_provider_arns | The Amazon Resource Name (ARN) of the IAM SAML identity provider. | saml_provider_arn |
| authentication_options_federated_authentication_self_service_saml_provider_arns | The Amazon Resource Name (ARN) of the IAM SAML identity provider for the self-service portal. | self_service_saml_provider_arn |
| connection_log_options_enabled | Indicates whether client connection logging is enabled for the Client VPN endpoint. | enabled |
| connection_log_options_cloudwatch_log_groups | The name of the Amazon CloudWatch Logs log group to which connection logging data is published. | cloudwatch_log_group |
| connection_log_options_cloudwatch_log_streams | The name of the Amazon CloudWatch Logs log stream to which connection logging data is published. | cloudwatch_log_stream |
| tags | Describes a tag. | tags |
| security_group_ids | The IDs of the security groups for the target network. | security_group_ids |
| vpc_id | The ID of the VPC. | vpc_id |
| self_service_portal_url | The URL of the self-service portal. | self_service_portal_url |
| client_connect_options_enabled | Indicates whether client connect options are enabled. | enabled |
| client_connect_options_lambda_function_arns | The Amazon Resource Name (ARN) of the Lambda function used for connection authorization. | lambda_function_arn |
| client_connect_options_status_codes | The status code. | status.code |
| client_connect_options_status_messages | The status message. | status.message |

## Examples

### Ensure a client VPN endpoint ID is available.

    describe aws_ec2_client_vpn_endpoints do
      its('client_vpn_endpoint_ids') { should include 'CLIENT_VPN_ENDPOINT_ID' }
    end

### Ensure that the status code is `available`.

    describe aws_ec2_client_vpn_endpoints do
        its('status_codes') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_endpoints do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_endpoints do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_endpoints do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnEndpointsResult` action with `Effect` set to `Allow`.