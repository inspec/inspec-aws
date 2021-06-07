---
title: About the aws_elasticloadbalancingv2_load_balancer Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_load\_balancer

Use the `aws_elasticloadbalancingv2_load_balancer` InSpec audit resource to test properties of a single specific ElasticLoadBalancingV2 LoadBalancer.

The AWS::ElasticLoadBalancingV2::LoadBalancer resource specifies an Application Load Balancer, a Network Load Balancer, or a Gateway Load Balancer.

## Syntax

Ensure that a Load Balancer Arn exists.
    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188') do
      it { should exist }
    end

## Parameters

`load_balancer_arn` _(required)_

For additional information, see the [AWS documentation on ElasticLoadBalancingV2 LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html).

## Properties

| Property | Description|
| --- | --- |
| load_balancer_arn | The Amazon Resource Name (ARN) of the load balancer. |
| dns_name | The public DNS name of the load balancer. |
| canonical_hosted_zone_id | The ID of the Amazon Route 53 hosted zone associated with the load balancer. |
| created_time | The date and time the load balancer was created. |
| load_balancer_name | The name of the load balancer. |
| scheme | The nodes of an Internet-facing load balancer have public IP addresses. The DNS name of an Internet-facing load balancer is publicly resolvable to the public IP addresses of the nodes. Therefore, Internet-facing load balancers can route requests from clients over the internet. The nodes of an internal load balancer have only private IP addresses. The DNS name of an internal load balancer is publicly resolvable to the private IP addresses of the nodes. Therefore, internal load balancers can route requests only from clients with access to the VPC for the load balancer. |
| vpc_id | The ID of the VPC for the load balancer. |
| state (code) | The state code. The initial state of the load balancer is provisioning . After the load balancer is fully set up and ready to route traffic, its state is active . If load balancer is routing traffic but does not have the resources it needs to scale, its state is active_impaired. If the load balancer could not be set up, its state is failed. |
| state (reason) | A description of the state. |
| type | The type of load balancer. |
| availability_zones (zone_name) | The name of the Availability Zone. |
| availability_zones (subnet_id) | The ID of the subnet. You can specify one subnet per Availability Zone. |
| availability_zones (outpost_id) | [Application Load Balancers on Outposts] The ID of the Outpost. |
| availability_zones (load_balancer_addresses (ip_address)) | The static IP address. |
| availability_zones (load_balancer_addresses (allocation_id)) | [Network Load Balancers] The allocation ID of the Elastic IP address for an internal-facing load balancer. |
| availability_zones (load_balancer_addresses (private_i_pv_4_address)) | [Network Load Balancers] The private IPv4 address for an internal load balancer. |
| availability_zones (load_balancer_addresses (i_pv_6_address)) | [Network Load Balancers] The IPv6 address. |
| security_groups | The IDs of the security groups for the load balancer. |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 (for IPv4 addresses) and dualstack (for IPv4 and IPv6 addresses). |
| customer_owned_ipv_4_pool | [Application Load Balancers on Outposts] The ID of the customer-owned address pool. |

## Examples

### Ensure a Load Balancer Arn is available.
    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188') do
      its('load_balancer_arn') { should eq 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188' }
    end

### Verify the load balancer name.
    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188') do
        its('load_balancer_name') { should eq 'my-load-balancer' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_load_balancers` action with `Effect` set to `Allow`.