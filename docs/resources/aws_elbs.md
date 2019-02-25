---
title: About the aws_elbs Resource
platform: aws
---

# aws\_elbs

Use the `aws_elbs` InSpec audit resource to test properties of some or all AWS Elastic Load Balancers.


<br>

## Syntax

An `aws_elbs` resource block returns all Elastic Load Balancers and allows the testing of that group of Load Balancers.

    describe aws_elbs do
      its('load_balancer_names') { should include 'elb-name' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.


    Ensure there are no Load Balancers with an undesired zone.

      describe aws_elbs do
        it                             { should exist }
        its('availability_zones')      { should_not include 'UNDESIRED-ZONE'}
      end
<br>

## Properties

* availability_zones 
* dns_names 
* load_balancer_names 
* external_ports 
* instance_ids
* internal_ports
* security_group_ids
* subnet_ids
* vpc_ids

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described ELB exists.

      describe aws_elbs.where( <property>: <value>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elasticloadbalancing:DescribeLoadBalancers` action set to Allow.

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
