+++
title = "aws_elb resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elb"
identifier = "inspec/resources/aws/aws_elb resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elb` InSpec audit resource to test properties of a single AWS Elastic Load Balancer (ELB).

For additional information, including details on parameters and properties, see the [AWS documentation on Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference).

## Syntax

An `aws_elb` resource block declares the tests for a single AWS ELB by ELB name. AWS ELB Names are unique per region.

```ruby
describe aws_elb('my-elb') do
  it { should exist }
end
```

```ruby
describe aws_elb(load_balancer_name: 'my-elb') do
  it { should exist }
end
```

## Parameters

`load_balancer_name` _(required)_

: This resource accepts a single parameter, the ELB Name which uniquely identifies the ELB.
  This can be passed either as a string or as a `load_balancer_name: 'value'` key-value entry in a hash.

## Properties

`load_balancer_name`
: The name of the load balancer.

`dns_name`
: The DNS name of the load balancer.

`availability_zones`
: The Availability Zones for the load balancer.

`instance_ids`
: An array containing all instance ids associated with the ELB.

`external_ports`
: An array of the external ports exposed on the ELB.

`internal_ports`
: An array of the internal ports exposed on the ELB.

`security_group_ids`
: The security groups for the load balancer. Valid only for load balancers in a VPC.

`vpc_id`
: The ID of the VPC for the load balancer.

`subnet_ids`
: The IDs of the subnets for the load balancer.

`listeners`
: A collection of the listeners for the load balancer.

`ssl_policies`
: A collection of the SSL Policies configured in-use for the load balancer (and their policy attributes).

`protocols`
: A list of the protocols configured for the listeners of the load balancer.

`cross_zone_load_balancing_enabled?`
: The cross-zone load balancing status for ELB.

`access_log_enabled?`
: The access log status for ELB.

`certificate_id`
: A list of SSL certificate IDs configured for the listeners of the load balancer.

## Examples

Test that cross-zone load balancing for ELB is enabled:

```ruby
describe aws_elb('prod_web_app_elb') do
  it { should be_cross_zone_load_balancing_enabled }
end
```

Test that access logs for ELB are enabled:

```ruby
describe aws_elb('prod_web_app_elb') do
  it { should be_access_log_enabled }
end
```

Test that an ELB has its availability zones configured correctly:

```ruby
describe aws_elb('prod_web_app_elb') do
  its('availability_zones.count') { should be > 1 }
  its('availability_zones')       { should include 'us-east-2a' }
  its('availability_zones')       { should include 'us-east-2b' }
end
```

Ensure an ELB has the correct number of EC2 Instances associated with it:

```ruby
describe aws_elb('prod_web_app_elb') do
  its('instance_ids.count') { should cmp 3 }
end
```

Ensure the correct DNS is set :

```ruby
describe aws_elb('prod_web_app_elb') do
  its('dns_name') { should cmp 'your-fqdn.com' }
end
```

Ensure we only expose port 80, both to the public and internal:

```ruby
describe aws_elb('prod_web_app_elb') do
  its('external_ports.count') { should cmp 1 }
  its('external_ports')       { should include 80 }
  its('internal_ports.count') { should cmp 1 }
  its('internal_ports')       { should include 80 }
end
```

Ensure the correct EC2 Instances are associated:

```ruby
describe aws_elb('prod_web_app_elb') do
  its('instance_ids') { should include 'i-12345678' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_elb('AnExistingELB') do
  it { should exist }
end
```

```ruby
describe aws_elb('ANonExistentELB') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancing:Client:DescribeAccessPointsOutput" %}}

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)
