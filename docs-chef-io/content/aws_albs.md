+++
title = "aws_albs resource"

draft = false


[menu.aws]
title = "aws_albs"
identifier = "inspec/resources/aws/aws_albs resource"
parent = "inspec/resources/aws"
+++

Use the `aws_albs` InSpec audit resource to test the configuration of a collection of Application Load Balancers.

For additional information, including details on parameters and properties, see the [AWS documentation on Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference).

## Syntax

Ensure that an `aws_albs` exists

```ruby
describe aws_albs do
  its('load_balancer_arns') { should include 'arn:aws:elasticloadbalancing' }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`load_balancer_names`
: The names of the load balancers.

`load_balancer_addresses`
: A collection of the load balancers addresses.

`canonical_hosted_zone_ids`
: The IDs of the Amazon Route 53 hosted zone for the load balancers.

`dns_names`
: The DNS names of the load balancers.

`availability_zones`
: The Availability Zones for the load balancers.

`security_groups`
: The security groups for the load balancers. Valid only for load balancers in a VPC.

`schemes`
: The types of load balancers. Valid only for load balancers in a VPC.

`states`
: The states of the load balancers.

`subnets`
: A collection of the subnet ids.

`types`
: The types of the load balancers.

`vpc_ids`
: The IDs of the VPCs for the load balancers.

`zone_names`
: A collection of the names of the availability zones.

## Examples

Test that an ALB has its availability zones configured correctly:

```ruby
describe aws_alb('arn::alb') do
  its('zone_names.count')  { should be > 1 }
  its('zone_names')        { should include 'us-east-2a' }
  its('zone_names')        { should include 'us-east-2b' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_albs do
  it                             { should exist }
  its('availability_zones')      { should_not include 'us-east-1a'}
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancing:Client:DescribeLoadBalancers" %}}

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
