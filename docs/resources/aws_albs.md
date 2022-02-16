---
title: About the aws_albs Resource
platform: aws
---

# aws_albs

Use the `aws_albs` InSpec audit resource to test the configuration of a collection of Application Load Balancers.

The `AWS::ElasticLoadBalancing::LoadBalancer` resource specifies a Classic Load Balancer.

## Syntax

Ensure that an `aws_albs` exists

    describe aws_albs do
      its('load_balancer_arns') { should include 'arn:aws:elasticloadbalancing' }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on the `AWS::ElasticLoadBalancing::LoadBalancer` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| load_balancer_names | The names of the load balancers. | load_balancer_name |
| load_balancer_addresses | A collection of the load balancers addresses. | load_balancer_addresses |
| canonical_hosted_zone_ids | The IDs of the Amazon Route 53 hosted zone for the load balancers. | canonical_hosted_zone_id |
| dns_names | The DNS names of the load balancers. | dns_name |
| availability_zones | The Availability Zones for the load balancers. | availability_zones |
| security_groups | The security groups for the load balancers. Valid only for load balancers in a VPC. | security_groups |
| schemes | The types of load balancers. Valid only for load balancers in a VPC. | scheme |
| states | The states of the load balancers. | scheme |
| subnets | A collection of the subnet ids. | subnet_id |
| types | The types of the load balancers. | type |
| vpc_ids | The IDs of the VPCs for the load balancers. | vpc_id |
| zone_names | A collection of the names of the availability zones. | zone_name |

## Examples

##### Test that an ALB has its availability zones configured correctly
    describe aws_alb('arn::alb') do
      its('zone_names.count')  { should be > 1 }
      its('zone_names')        { should include 'us-east-2a' }
      its('zone_names')        { should include 'us-east-2b' }
    end

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test that the entity exists.

    describe aws_albs do
      it { should exist }
      its('availability_zones')      { should_not include 'us-east-1a'}
    end

Use `should_not` to test the entity does not exist.

    describe aws_albs do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticLoadBalancing:Client:DescribeLoadBalancers` action set to Allow.

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
