---
title: About the aws_elasticloadbalancingv2_load_balancers Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_load\_balancers

Use the `aws_elasticloadbalancingv2_load_balancers` InSpec audit resource to test properties of multiple Application Load Balancers, Network Load Balancers, or Gateway Load Balancers.

## Syntax

Ensure that a Load Balancer Arn exists.
    describe aws_elasticloadbalancingv2_load_balancers do
      it { should exist }
    end

## Parameters

No Required Parameters

For additional information, see the [AWS documentation on ElasticLoadBalancingV2 LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html).

## Properties

| Property | Description|
| --- | --- |
| load_balancer_arns | The Amazon Resource Name (ARN) of the load balancer. |
| dns_names | The public DNS name of the load balancer. |
| canonical_hosted_zone_ids | The ID of the Amazon Route 53 hosted zone associated with the load balancer. |
| created_times | The date and time the load balancer was created. |
| load_balancer_name | The name of the load balancer. |
| schemes | The type of load balancer. You cannot specify a scheme for a Gateway Load Balancer. Valid values are `internal` or `internet-facing`. |
| vpc_ids | The ID of the VPC for the load balancer. |
| states | The state of the load balancer. |
| types | The type of load balancer. Valid values are: `application`, `gateway`, or `network`. |
| availability_zones | The subnets for the load balancer. |
| security_groups | The IDs of the security groups for the load balancer. |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` (for IPv4 addresses) and `dualstack` (for IPv4 and IPv6 addresses). |
| customer_owned_ipv_4_pool | For Application Load Balancers on AWS Outposts, the ID of the customer-owned address pool. |


## Examples

### Ensure a load balancer ARN is available.

    describe aws_elasticloadbalancingv2_load_balancers do
      its('load_balancer_arn') { should include 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID' }
    end

### Verify the load balancer name exists.

    describe aws_elasticloadbalancingv2_load_balancers do
        its('load_balancer_name') { should include 'LOAD_BALANCER_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_load_balancers do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_elasticloadbalancingv2_load_balancers do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Load Balancer Arn is available.

    describe aws_elasticloadbalancingv2_load_balancers do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_load_balancers` action with `Effect` set to `Allow`.
