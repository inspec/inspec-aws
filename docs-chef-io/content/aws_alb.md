+++
title = "aws_alb resource"

draft = false


[menu.aws]
title = "aws_alb"
identifier = "inspec/resources/aws/aws_alb resource"
parent = "inspec/resources/aws"
+++

Use the `aws_alb` InSpec audit resource to test properties of a single AWS Application Load Balancer (ALB).

For additional information, including details on parameters and properties, see the [AWS documentation on Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference).

## Syntax

Ensure that an `aws_alb` exists

```ruby
describe aws_alb('arn:aws:elasticloadbalancing') do
  it { should exist }
end
```

```ruby
describe aws_alb(load_balancer_arn: 'arn:aws:elasticloadbalancing') do
  it { should exist }
end
```

## Parameters

`load_balancer_arn` _(required)_

: This resource accepts a single parameter, the ALB Arn which uniquely identifies the ALB.
  This can be passed either as a string or as a `load_balancer_arn: 'value'` key-value entry in a hash.

## Properties

`load_balancer_name`
: The name of the load balancer.

`load_balancer_addresses`
: A collectionm of the load balancer addresses.

`canonical_hosted_zone_id`
: The ID of the Amazon Route 53 hosted zone for the load balancer.

`dns_name`
: The DNS name of the load balancer.

`availability_zones`
: The Availability Zones for the load balancer.

`security_groups`
: The security groups for the load balancer. Valid only for load balancers in a VPC.

`scheme`
: The type of load balancer. Valid only for load balancers in a VPC.

`state`
: The state of the load balancer.

`subnets`
: A collection of the subnet ids.

`type`
: The type of the load balancer.

`access_log_enabled`
: Whether the access log for the load balancer is enabled.

`vpc_id`
: The ID of the VPC for the load balancer.

`zone_names`
: A collection of the names of the availability zones.

`listeners`
: A collection of the listeners for the load balancer.

`ssl_policies`
: A list of the SSL Policies configured for the listeners of the load balancer.

`external_ports`
: A list of the ports configured for the listeners of the load balancer.

`protocols`
: A list of the protocols configured for the listeners of the load balancer.

## Examples

Test that an ALB has its availability zones configured correctly:

```ruby
describe aws_alb('arn::alb') do
  its('zone_names.count')  { should be > 1 }
  its('zone_names')        { should include 'us-east-2a' }
  its('zone_names')        { should include 'us-east-2b' }
end
```

Test whether the access log is enabled for the Application Load Balancer:

```ruby
describe aws_alb('load_balancer_arn::alb') do
  it                         { should exist }
  its ('access_log_enabled') { should eq true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_alb('AnExistingALB') do
  it { should exist }
end
```

```ruby
describe aws_alb('ANonExistentALB') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancing:Client:DescribeLoadBalancers" %}}

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
