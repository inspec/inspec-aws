---
title: About the aws_albs Resource
platform: aws
---

# aws\_albs

Use the `aws_albs` InSpec audit resource to test the configuration of a collection of Application Load Balancers.

## Syntax

Ensure that an `aws_albs` exists

    describe aws_albs do
      its('load_balancer_arns') { should include 'arn:aws:elasticloadbalancing' }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference).

## Properties

|Property                    | Description|
| ---                        | --- |
|load\_balancer\_name        | The name of the load balancer. |
|load\_balancer\_addresses   | A collectionm of the load balancer addresses. |
|canonical\_hosted\_zone\_id | The ID of the Amazon Route 53 hosted zone for the load balancer. |
|dns\_name                   | The DNS name of the load balancer. |
|availability\_zones         | The Availability Zones for the load balancer. |
|security\_groups            | The security groups for the load balancer. Valid only for load balancers in a VPC. |
|scheme                      | The type of load balancer. Valid only for load balancers in a VPC. |
|state                       | The state of the load balancer. |
|subnets                     | A collection of the subnet ids. |
|type                        | The type of the load balancer. |
|vpc\_id                     | The ID of the VPC for the load balancer. |
|zone\_names                 | A collection of the names of the availability zones. |

## Examples

##### Test that an ALB has its availability zones configured correctly
    describe aws_alb('arn::alb') do
      its('zone_names.count')  { should be > 1 }
      its('zone_names')        { should include 'us-east-2a' }
      its('zone_names')        { should include 'us-east-2b' }
    end

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_albs do
      it                             { should exist }
      its('availability_zones')      { should_not include 'us-east-1a'}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elasticloadbalancing:DescribeLoadBalancers` action set to Allow.

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
