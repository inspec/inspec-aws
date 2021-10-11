---
title: About the aws_elasticloadbalancingv2_load_balancer Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_load\_balancer

Use the `aws_elasticloadbalancingv2_load_balancer` InSpec audit resource to test properties of a single Application Load Balancer, Network Load Balancer, or Gateway Load Balancer.

## Syntax

Ensure that a Load Balancer Arn exists.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
      it { should exist }
    end

## Parameters

`load_balancer_arn` _(required)_

The Amazon Resource Name (ARN) of the load balancer.

For additional information, see the [AWS documentation on ElasticLoadBalancingV2 LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html).

## Properties

| Property | Description|
| --- | --- |
| load_balancer_arn | The Amazon Resource Name (ARN) of the load balancer. |
| dns_name | The public DNS name of the load balancer. |
| canonical_hosted_zone_id | The ID of the Amazon Route 53 hosted zone associated with the load balancer. |
| created_time | The date and time the load balancer was created. |
| load_balancer_name | The name of the load balancer. |
| scheme | The type of load balancer. You cannot specify a scheme for a Gateway Load Balancer. Valid values are `internal` or `internet-facing`. |
| vpc_id | The ID of the VPC for the load balancer. |
| state (code) | The state code of the load balancer. The initial state of the load balancer is `provisioning`. After the load balancer is fully set up and ready to route traffic, its state is `active`. If load balancer is routing traffic but does not have the resources it needs to scale, its state is `active_impaired`. If the load balancer could not be set up, its state is `failed`. |
| state (reason) | A description of the state. |
| type | The type of load balancer. Valid values are: `application`, `gateway`, or `network`. |
| availability_zones (zone_name) | The name of the Availability Zone. |
| availability_zones (subnet_id) | The ID of the subnet. You can specify one subnet per Availability Zone. |
| availability_zones (outpost_id) | For load balancers on AWS Outposts, the ID of the Outpost. |
| availability_zones (load_balancer_addresses (ip_address)) | The static IP address. |
| availability_zones (load_balancer_addresses (allocation_id)) | For Network Load Balancers, the allocation ID of the Elastic IP address for an internal-facing load balancer. |
| availability_zones (load_balancer_addresses (private_i_pv_4_address)) | For Network Load Balancers, the private IPv4 address for an internal load balancer. |
| availability_zones (load_balancer_addresses (i_pv_6_address)) | For Network Load Balancers, the IPv6 address. |
| security_groups | The IDs of the security groups for the load balancer. |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` (for IPv4 addresses) and `dualstack` (for IPv4 and IPv6 addresses). |
| customer_owned_ipv_4_pool | For load balancers on AWS Outposts, the ID of the customer-owned address pool. |

## Examples

### Ensure a load balancer ARN is available.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
      its('load_balancer_arn') { should eq 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID' }
    end

### Verify the load balancer name.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
        its('load_balancer_name') { should eq 'my-load-balancer' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticLoadBalancingV2:Client:DescribeLoadBalancersOutput` action with `Effect` set to `Allow`.
