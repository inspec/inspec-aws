---
title: About the aws_ec2_network_insights_analysis Resource
platform: aws
---

# aws_ec2_network_insights_analysis

Use the `aws_ec2_network_insights_analysis` InSpec audit resource to test properties of a single specific AWS EC2 Network Insights Analysis.

The AWS::EC2::NetworkInsightsAnalysis resource specifies a network insights analysis.

## Syntax

Ensure that function exists.

    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
      it { should exist }
    end

## Parameters

`function_name` _(required)_

| Property | Description |
| --- | --- |
| network_insights_analysis_id | The ID of the network insights analysis. |

For additional information, see the [AWS documentation on AWS EC2 Network Insights Analysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| network_insights_analysis_id | The ID of the network insights analysis. | network_insights_analysis_id |
| network_insights_analysis_arn | The Amazon Resource Name (ARN) of the network insights analysis. | network_insights_analysis_arn |
| network_insights_path_id | The ID of the path. | network_insights_path_id |
| filter_in_arns | The Amazon Resource Names (ARN) of the Amazon Web Services resources that the path must traverse. | filter_in_arns |
| start_date | The time the analysis started. | start_date |
| status | The status of the network insights analysis. | status |
| status_message | The status message, if the status is failed. | status_message |
| network_path_found | Indicates whether the destination is reachable from the source. | network_path_found |

| needschanges | The components in the path from source to destination. | forward_path_components |
| needschanges | The sequence number. | forward_path_components (sequence_number) |
| needschanges | The IPv4 address range, in CIDR notation. | forward_path_components (acl_rule (cidr)) |
| needschanges | Indicates whether the rule is an outbound rule. | forward_path_components (acl_rule (egress)) |
| needschanges | The range of ports. The first port in the range. | forward_path_components (acl_rule (port_range (from))) |
| needschanges | The range of ports. The last port in the range. | forward_path_components (acl_rule (port_range (to))) |
| needschanges | The acl rule protocol. | forward_path_components (acl_rule (protocol)) |
| fneedschanges | Indicates whether to allow or deny traffic that matches the rule. | forward_path_components (acl_rule (rule_action)) |
| needschanges | The rule number. | forward_path_components (acl_rule (rule_number)) |
| needschanges | The ID of the component. | forward_path_components (component (id)) |
| needschanges | The Amazon Resource Name (ARN) of the component. | forward_path_components (component (arn)) |
| needschanges | The ID of the component. | forward_path_components (destination_vpc (id)) |
| needschanges | The Amazon Resource Name (ARN) of the component. | forward_path_components (destination_vpc (arn)) |
| needschanges | The outbound header destination addresses. | forward_path_components (outbound_header (destination_addresses)) |
| needschanges | The outbound header destination port ranges. | forward_path_components (outbound_header (destination_port_ranges)) |
| needschanges | The outbound header destination port ranges. The first port in the range. | forward_path_components (outbound_header (destination_port_ranges (from))) |
| needschanges | The outbound header destination port ranges. The last port in the range. | forward_path_components (outbound_header (destination_port_ranges (to))) |
| needschanges | The protocol. | forward_path_components (outbound_header (protocol)) |
| needschanges | The source addresses. | forward_path_components (outbound_header (source_addresses)) |
| needschanges | The source port ranges. | forward_path_components (outbound_header (source_port_ranges)) |
| needschanges | The source port ranges. The first port in the range. | forward_path_components (outbound_header (source_port_ranges (from))) |
| needschanges | The source port ranges. The last port in the range. | forward_path_components (outbound_header (source_port_ranges (to))) |
| needschanges | The inbound header destination addresses. | forward_path_components (inbound_header (destination_addresses)) |
| needschanges | The inbound header destination port ranges. | forward_path_components (inbound_header (destination_port_ranges)) |
| needschanges | The inbound header destination port ranges. The first port in the range. | forward_path_components (inbound_header (destination_port_ranges (from))) |
| needschanges | The inbound header destination port ranges. The last port in the range. | forward_path_components (inbound_header (destination_port_ranges (to))) |
| needschanges | The inbound header protocol. | forward_path_components (inbound_header (protocol)) |
| needschanges | The inbound header source addresses. | forward_path_components (inbound_header (source_addresses)) |
| needschanges | The inbound header source port ranges. | forward_path_components (inbound_header (source_port_ranges)) |
| needschanges | The inbound header source port ranges. The first port in the range. | forward_path_components (inbound_header (source_port_ranges (from))) |
| needschanges | The inbound header source port ranges. The last port in the range. | forward_path_components (inbound_header (source_port_ranges (to))) |
| needschanges | The route table route. The destination IPv4 address, in CIDR notation. | forward_path_components (route_table_route (destination_cidr)) |
| needschanges | The route table route. The prefix of the Amazon Web Service. | forward_path_components (route_table_route (destination_prefix_list_id)) |
| needschanges | The route table route. The ID of an egress-only internet gateway. | forward_path_components (route_table_route (egress_only_internet_gateway_id)) |
| needschanges | The route table route. The ID of the gateway, such as an internet gateway or virtual private gateway. | forward_path_components (route_table_route (gateway_id)) |
| needschanges | The route table route. The ID of the instance, such as a NAT instance. | forward_path_components (route_table_route (instance_id)) |
| needschanges | The route table route. The ID of a NAT gateway. | forward_path_components (route_table_route (nat_gateway_id)) |
| needschanges | The route table route. The ID of a network interface. | forward_path_components (route_table_route (network_interface_id)) |
| needschanges | The route table route. Describes how the route was created. | forward_path_components (route_table_route (origin)) |
| needschanges | The route table route. The ID of a transit gateway. | forward_path_components (route_table_route (transit_gateway_id)) |
| needschanges | The route table route. The ID of a VPC peering connection. | forward_path_components (route_table_route (vpc_peering_connection_id)) |
| needschanges | The security group rule. The IPv4 address range, in CIDR notation. | forward_path_components (security_group_rule (cidr)) |
| needschanges | The security group rule. The direction. The following are possible values are egress and ingress. | forward_path_components (security_group_rule (direction) |
| needschanges | The security group rule. The security group ID. | forward_path_components (security_group_rule (security_group_id)) |
| needschanges | The security group rule. The port range. The first port in the range. | forward_path_components (security_group_rule (port_range (from))) |
| needschanges | The security group rule. The port range. The last port in the range. | forward_path_components (security_group_rule (port_range (to))) |
| needschanges | The security group rule. The prefix list ID. | forward_path_components (security_group_rule (prefix_list_id)) |
| needschanges | The security group rule. The protocol name. | forward_path_components (security_group_rule (protocol)) |
| needschanges | The source VPC. The ID of the component. | forward_path_components (source_vpc (id)) |
| needschanges | The source VPC. The Amazon Resource Name (ARN) of the component. | forward_path_components (source_vpc (arn)) |
| needschanges | The subnet. The ID of the component. | forward_path_components (subnet (id)) |
| needschanges | The subnet. The Amazon Resource Name (ARN) of the component. | forward_path_components (subnet (arn)) |
| needschanges | The vpc. The ID of the component. | forward_path_components (vpc (id)) |
| needschanges | The vpc. The Amazon Resource Name (ARN) of the component. | forward_path_components (vpc (arn)) |

| needschanges | The components in the path from destination to source. | return_path_components |
| needschanges | The sequence number. | return_path_components (sequence_number) |
| needschanges | The IPv4 address range, in CIDR notation. | return_path_components (acl_rule (cidr)) |
| needschanges | Indicates whether the rule is an outbound rule. | return_path_components (acl_rule (egress)) |
| needschanges | The range of ports. The first port in the range. | return_path_components (acl_rule (port_range (from))) |
| needschanges | The range of ports. The last port in the range. | return_path_components (acl_rule (port_range (to))) |
| needschanges | The acl rule protocol. | return_path_components (acl_rule (protocol)) |
| fneedschanges | Indicates whether to allow or deny traffic that matches the rule. | return_path_components (acl_rule (rule_action)) |
| needschanges | The rule number. | return_path_components (acl_rule (rule_number)) |
| needschanges | The ID of the component. | return_path_components (component (id)) |
| needschanges | The Amazon Resource Name (ARN) of the component. | return_path_components (component (arn)) |
| needschanges | The ID of the component. | return_path_components (destination_vpc (id)) |
| needschanges | The Amazon Resource Name (ARN) of the component. | return_path_components (destination_vpc (arn)) |
| needschanges | The outbound header destination addresses. | return_path_components (outbound_header (destination_addresses)) |
| needschanges | The outbound header destination port ranges. | return_path_components (outbound_header (destination_port_ranges)) |
| needschanges | The outbound header destination port ranges. The first port in the range. | return_path_components (outbound_header (destination_port_ranges (from))) |
| needschanges | The outbound header destination port ranges. The last port in the range. | return_path_components (outbound_header (destination_port_ranges (to))) |
| needschanges | The protocol. | return_path_components (outbound_header (protocol)) |
| needschanges | The source addresses. | return_path_components (outbound_header (source_addresses)) |
| needschanges | The source port ranges. | return_path_components (outbound_header (source_port_ranges)) |
| needschanges | The source port ranges. The first port in the range. | return_path_components (outbound_header (source_port_ranges (from))) |
| needschanges | The source port ranges. The last port in the range. | return_path_components (outbound_header (source_port_ranges (to))) |
| needschanges | The inbound header destination addresses. | return_path_components (inbound_header (destination_addresses)) |
| needschanges | The inbound header destination port ranges. | return_path_components (inbound_header (destination_port_ranges)) |
| needschanges | The inbound header destination port ranges. The first port in the range. | return_path_components (inbound_header (destination_port_ranges (from))) |
| needschanges | The inbound header destination port ranges. The last port in the range. | return_path_components (inbound_header (destination_port_ranges (to))) |
| needschanges | The inbound header protocol. | return_path_components (inbound_header (protocol)) |
| needschanges | The inbound header source addresses. | return_path_components (inbound_header (source_addresses)) |
| needschanges | The inbound header source port ranges. | return_path_components (inbound_header (source_port_ranges)) |
| needschanges | The inbound header source port ranges. The first port in the range. | return_path_components (inbound_header (source_port_ranges (from))) |
| needschanges | The inbound header source port ranges. The last port in the range. | return_path_components (inbound_header (source_port_ranges (to))) |
| needschanges | The route table route. The destination IPv4 address, in CIDR notation. | return_path_components (route_table_route (destination_cidr)) |
| needschanges | The route table route. The prefix of the Amazon Web Service. | return_path_components (route_table_route (destination_prefix_list_id)) |
| needschanges | The route table route. The ID of an egress-only internet gateway. | return_path_components (route_table_route (egress_only_internet_gateway_id)) |
| needschanges | The route table route. The ID of the gateway, such as an internet gateway or virtual private gateway. | return_path_components (route_table_route (gateway_id)) |
| needschanges | The route table route. The ID of the instance, such as a NAT instance. | return_path_components (route_table_route (instance_id)) |
| needschanges | The route table route. The ID of a NAT gateway. | return_path_components (route_table_route (nat_gateway_id)) |
| needschanges | The route table route. The ID of a network interface. | return_path_components (route_table_route (network_interface_id)) |
| needschanges | The route table route. Describes how the route was created. | return_path_components (route_table_route (origin)) |
| needschanges | The route table route. The ID of a transit gateway. | return_path_components (route_table_route (transit_gateway_id)) |
| needschanges | The route table route. The ID of a VPC peering connection. | return_path_components (route_table_route (vpc_peering_connection_id)) |
| needschanges | The security group rule. The IPv4 address range, in CIDR notation. | return_path_components (security_group_rule (cidr)) |
| needschanges | The security group rule. The direction. The following are possible values are egress and ingress. | return_path_components (security_group_rule (direction) |
| needschanges | The security group rule. The security group ID. | return_path_components (security_group_rule (security_group_id)) |
| needschanges | The security group rule. The port range. The first port in the range. | return_path_components (security_group_rule (port_range (from))) |
| needschanges | The security group rule. The port range. The last port in the range. | return_path_components (security_group_rule (port_range (to))) |
| needschanges | The security group rule. The prefix list ID. | return_path_components (security_group_rule (prefix_list_id)) |
| needschanges | The security group rule. The protocol name. | return_path_components (security_group_rule (protocol)) |
| needschanges | The source VPC. The ID of the component. | return_path_components (source_vpc (id)) |
| needschanges | The source VPC. The Amazon Resource Name (ARN) of the component. | return_path_components (source_vpc (arn)) |
| needschanges | The subnet. The ID of the component. | return_path_components (subnet (id)) |
| needschanges | The subnet. The Amazon Resource Name (ARN) of the component. | return_path_components (subnet (arn)) |
| needschanges | The vpc. The ID of the component. | return_path_components (vpc (id)) |
| needschanges | The vpc. The Amazon Resource Name (ARN) of the component. | return_path_components (vpc (arn)) |

| needschanges | The explanations. | explanations |
| needschanges | The explanations. The network ACL. The ID of the component. | explanations (acl (id)) |
| needschanges | The explanations. The network ACL. The Amazon Resource Name (ARN) of the component. | explanations (acl (arn)) |
| needschanges | The explanations. The network ACL rule. The IPv4 address range, in CIDR notation. | explanations (acl_rule (cidr)) |
| needschanges | The explanations. The network ACL rule. Indicates whether the rule is an outbound rule. | explanations (acl_rule (egress)) |
| needschanges | The explanations. The network ACL rule. The range of ports. The first port in the range. | explanations (acl_rule (port_range (from))) |
| needschanges | The explanations. The network ACL rule. The range of ports. The last port in the range. | explanations (acl_rule (port_range (to))) |
| needschanges | The explanations. The network ACL rule. The protocol. | explanations (acl_rule (protocol)) |
| needschanges | The explanations. The network ACL rule. Indicates whether to allow or deny traffic that matches the rule. | explanations (acl_rule (rule_action)) |
| needschanges | The explanations. The network ACL rule. The rule number. | explanations (acl_rule (rule_number)) |
| needschanges | The explanations. The IPv4 address, in CIDR notation. | explanations (address) |
| needschanges | The explanations. The IPv4 addresses, in CIDR notation. | explanations (addresses) |
| needschanges | The explanations. The resource to which the component is attached. The ID of the component. | explanations (attached_to (id)) |
| needschanges | The explanations. The resource to which the component is attached. The arn of the component. | explanations (attached_to (arn)) |
| needschanges | The explanations. The Availability Zones. | explanations (availability_zones) |
| needschanges | The explanations. The CIDR ranges. | explanations (cidrs) |
| needschanges | The explanations. The component. The ID of the component. | explanations (component (id)) |
| needschanges | The explanations. The component. The arn of the component. | explanations (component (arn)) |
| needschanges | The explanations. The customer gateway. The ID of the component. | explanations (customer_gateway (id)) |
| needschanges | The explanations. The customer gateway. The arn of the component. | explanations (customer_gateway (arn)) |
| needschanges | The explanations. The destination. The ID of the destination. | explanations (destination (id)) |
| needschanges | The explanations. The destination. The arn of the destination. | explanations (destination (arn)) |
| needschanges | The explanations. The destination VPC. The ID of the destination VPC. | explanations (destination_vpc (id)) |
| needschanges | The explanations. The destination VPC. The arn of the destination VPC. | explanations (destination_vpc (arn)) |
| needschanges | The explanations. The direction. Possible values are egress and ingress. | explanations (direction) |
| needschanges | The explanations. The explanation code. | explanations (explanation_code) |
| needschanges | The explanations. The route table. The ID of the component. | explanations (ingress_route_table (id)) |
| needschanges | The explanations. The route table. The arn of the component. | explanations (ingress_route_table (arn)) |
| needschanges | The explanations. The internet gateway. The ID of the component. | explanations (internet_gateway (id)) |
| needschanges | The explanations. The internet gateway. The arn of the component. | explanations (internet_gateway (arn)) |
| needschanges | The explanations. The Amazon Resource Name (ARN) of the load balancer. | explanations (load_balancer_arn) |
| needschanges | The explanations. The listener for a Classic Load Balancer. The port on which the load balancer is listening. | explanations (classic_load_balancer_listener (load_balancer_port)) |
| needschanges | The explanations. The listener for a Classic Load Balancer. The back-end port for the listener. | explanations (classic_load_balancer_listener (instance_port)) |
| needschanges | The explanations. The listener port of the load balancer. | explanations (load_balancer_listener_port) |
| needschanges | The explanations. The target. The IP address. | explanations (load_balancer_target (address)) |
| needschanges | The explanations. The target. The Availability Zone. | explanations (load_balancer_target (availability_zone)) |
| needschanges | The explanations. The target. Information about the instance. The ID of the component. | explanations (load_balancer_target (instance (id))) |
| needschanges | The explanations. The target. Information about the instance. The arn of the component. | explanations (load_balancer_target (instance (arn))) |
| needschanges | The explanations. The target. The port on which the target is listening. | explanations (load_balancer_target (port)) |
| needschanges | The explanations. The target group. The ID of the component. | explanations (load_balancer_target_group (id)) |
| needschanges | The explanations. The target group. The arn of the component. | explanations (load_balancer_target_group (arn)) |
| needschanges | The explanations. The target group. | explanations (load_balancer_target_groups) |
| needschanges | The explanations. The target group. The ID of the component. | explanations (load_balancer_target_groups (id)) |
| needschanges | The explanations. The target group. The arn of the component. | explanations (load_balancer_target_groups (arn)) |
| needschanges | The explanations. The target port. | explanations (load_balancer_target_port)) |
| needschanges | The explanations. The load balancer listener. The ID of the component. | explanations (elastic_load_balancer_listener (id)) |
| needschanges | The explanations. The load balancer listener. The arn of the component. | explanations (elastic_load_balancer_listener (arn)) |
| needschanges | The explanations. The missing component. | explanations (missing_component) |
| needschanges | The explanations. The NAT gateway. The ID of the component. | explanations (nat_gateway (id)) |
| needschanges | The explanations. The NAT gateway. The arn of the component. | explanations (nat_gateway (arn)) |
| needschanges | The explanations. The network interface. The ID of the component. | explanations (network_interface (id)) |
| needschanges | The explanations. The network interface.  The arn of the component. | explanations (network_interface (arn)) |
| needschanges | The explanations. The packet field. | explanations (packet_field) |
| needschanges | The explanations. The VPC peering connection. The ID of the component. | explanations (vpc_peering_connection (id)) |
| needschanges | The explanations. The VPC peering connection. The arn of the component. | explanations (vpc_peering_connection (arn)) |
| needschanges | The explanations. The port. | explanations (port) |
| needschanges | The explanations. The port ranges. | explanations (port_ranges) |
| needschanges | The explanations. The port ranges. The first port in the range. | explanations (port_ranges (from)) |
| needschanges | The explanations. The port ranges. The last port in the range. | explanations (port_ranges (to)) |
| needschanges | The explanations. The prefix list. The ID of the component. | explanations (prefix_list (id)) |
| needschanges | The explanations. The prefix list. The arn of the component. | explanations (prefix_list (arn)) |
| needschanges | The explanations. The protocols. | explanations (protocols) |
| needschanges | The explanations. The route table route. The destination IPv4 address, in CIDR notation. | explanations (route_table_route (destination_cidr)) |
| needschanges | The explanations. The route table route. The prefix of the Amazon Web Service. | explanations (route_table_route (destination_prefix_list_id)) |
| needschanges | The explanations. The route table route. The ID of an egress-only internet gateway. | explanations (route_table_route (egress_only_internet_gateway_id)) |
| needschanges | The explanations. The route table route. The ID of the gateway, such as an internet gateway or virtual private gateway. | explanations (route_table_route (gateway_id)) |
| needschanges | The explanations. The route table route. The ID of the instance, such as a NAT instance. | explanations (route_table_route (instance_id)) |
| needschanges | The explanations. The route table route. The ID of a NAT gateway. | explanations (route_table_route (nat_gateway_id)) |
| needschanges | The explanations. The route table route. The ID of a network interface. | explanations (route_table_route (network_interface_id)) |
| needschanges | The explanations. The route table route. Describes how the route was created. | explanations (route_table_route (origin)) |
| needschanges | The explanations. The route table route. The ID of a transit gateway. | explanations (route_table_route (transit_gateway_id)) |
| needschanges | The explanations. The route table route. The ID of a VPC peering connection. | explanations (route_table_route (vpc_peering_connection_id)) |
| needschanges | The explanations. The route table. The ID of the component. | explanations (route_table (id)) |
| needschanges | The explanations. The route table. The arn of the component. | explanations (route_table (arn)) |
| needschanges | The explanations. The security group. The ID of the component. | explanations (security_group (id)) |
| needschanges | The explanations. The security group. The arn of the component. | explanations (security_group (arn)) |
| needschanges | The explanations. The security group rule. The IPv4 address range, in CIDR notation. | explanations (security_group_rule (cidr)) |
| needschanges | The explanations. The security group rule. The direction. The following are possible values are egress and ingress. | explanations (security_group_rule (direction)) |
| needschanges | The explanations. The security group rule. The security group ID. | explanations (security_group_rule (security_group_id)) |
| needschanges | The explanations. The security group rule. The port range. The first port in the range. | explanations (security_group_rule (port_range (from))) |
| needschanges | The explanations. The security group rule. The port range. The last port in the range. | explanations (security_group_rule (port_range (to))) |
| needschanges | The explanations. The security group rule. The prefix list ID. | explanations (security_group_rule (prefix_list_id)) |
| needschanges | The explanations. The security group rule. The protocol name. | explanations (security_group_rule (protocol)) |
| needschanges | The explanations. The security groups. | explanations (security_groups) |
| needschanges | The explanations. The security groups. The ID of the component. | explanations (security_groups (id)) |
| needschanges | The explanations. The security groups. The arn of the component. | explanations (security_groups (arn)) |
| needschanges | The explanations. The source VPC. The ID of the component. | explanations (source_vpc (id)) |
| needschanges | The explanations. The source VPC. The arn of the component. | explanations (source_vpc (arn)) |
| needschanges | The explanations. The state. | explanations (state) |
| needschanges | The explanations. The subnet. The ID of the component. | explanations (subnet (id)) |
| needschanges | The explanations. The subnet. The arn of the component. | explanations (subnet (arn)) |
| needschanges | The explanations. The route table for the subnet. The ID of the component. | explanations (subnet_route_table (id)) |
| needschanges | The explanations. The route table for the subnet. The arn of the component. | explanations (subnet_route_table (arn)) |
| needschanges | The explanations. The component VPC. The ID of the component. | explanations (vpc (id)) |
| needschanges | The explanations. The component VPC. The arn of the component. | explanations (vpc (arn)) |
| needschanges | The explanations. The VPN endpoint. The ID of the component. | explanations (vpc_endpoint (id)) |
| needschanges | The explanations. The VPN endpoint. The arn of the component. | explanations (vpc_endpoint (arn)) |
| needschanges | The explanations. The VPN connection. The ID of the component. | explanations (vpn_connection (id)) |
| needschanges | The explanations. The VPN connection. The arn of the component. | explanations (vpn_connection (arn)) |
| needschanges | The explanations. The VPN gateway. The ID of the component. | explanations (vpn_gateway (id)) |
| needschanges | The explanations. The VPN gateway. The arn of the component. | explanations (vpn_gateway (arn)) |
| needschanges | Potential intermediate components. | alternate_path_hints |
| needschanges | Potential intermediate components. The ID of the component. | alternate_path_hints (component_id) |
| needschanges | Potential intermediate components. The arn of the component. | alternate_path_hints (component_arn) |

| tags | The | tags |

## Examples

### Ensure a Network Insights Analysis Id is available.
    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
      its('network_insights_analysis_id') { should eq 'NetworkInsightsAnalysisId' }
    end

### Ensure that the Network Insights Path Id is available.
    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
        its('network_insights_path_id') { should eq 'NetworkInsightsPathId' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NetworkInsightsAnalysisId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `lambda:client:DescribeNetworkInsightsAnalysesResult` action with `Effect` set to `Allow`.