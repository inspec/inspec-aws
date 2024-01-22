+++
title = "aws_elasticloadbalancingv2_target_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_elasticloadbalancingv2_target_group"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_target_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_target_group` InSpec audit resource to test properties of a single Elastic Load Balancing V2 target group.

For additional information, including details on parameters and properties, see the [AWS documentation on ElasticLoadBalancingV2 TargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a target group arn exists.
```ruby
describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
  it { should exist }
end
```

## Parameters

`target_group_arn` _(required)_

: The Amazon Resource Name (ARN) of the target group.

## Properties

`target_group_arn`
: The Amazon Resource Name (ARN) of the target group.

`target_group_name`
: The name of the target group.

`protocol`
: The protocol to use for routing traffic to the targets. Valid values are: `GENEVE`, `HTTP`, `HTTPS`, `TCP`, `TCP_UDP`, `TLS`, or `UDP`.

`port`
: The port on which the targets are listening. Not used if the target is a Lambda function.

`vpc_id`
: The ID of the VPC for the targets.

`health_check_protocol`
: The protocol to use to connect with the target. The GENEVE, TLS, UDP, and TCP_UDP protocols are not supported for health checks.

`health_check_port`
: The port to use to connect with the target.

`health_check_enabled`
: Indicates whether health checks are enabled.

`health_check_interval_seconds`
: The approximate amount of time, in seconds, between health checks of an individual target.

`health_check_timeout_seconds`
: The amount of time, in seconds, during which no response means a failed health check.

`healthy_threshold_count`
: The number of consecutive health check successes required before considering an unhealthy target healthy.

`unhealthy_threshold_count`
: The number of consecutive health check failures required before considering the target unhealthy.

`health_check_path`
: The destination for health checks on the targets.

`matcher (http_code)`
: For Application Load Balancers, you can specify values between 200 and 499, and the default value is 200. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299"). For Network Load Balancers and Gateway Load Balancers, this must be "200–399".

`matcher (grpc_code)`
: You can specify values between 0 and 99. You can specify multiple values (for example, "0,1") or a range of values (for example, "0-5"). The default value is 12.

`load_balancer_arns`
: The Amazon Resource Names (ARN) of the load balancers that route traffic to this target group.

`target_type`
: The type of target that you must specify when registering targets with this target group. The possible values are instance (register targets by instance ID), ip (register targets by IP address), or lambda (register a single Lambda function as a target).

`protocol_version`
: For HTTP or HTTPS protocols, the protocol version. Valid values are `GRPC`, `HTTP1`, and `HTTP2`.

## Examples

**Ensure a target group ARN is available.**

```ruby
describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
  its('target_group_arn') { should eq 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID' }
end
```

**Ensure that the target group name exists.**

```ruby
describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
    its('target_group_name') { should eq 'TARGET_GROUP_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticloadbalancingv2_target_group(   target_group_arn: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_elasticloadbalancingv2_target_group(target_group_arn: 'arn:aws:elasticloadbalancing:REGION:ACCOUNT_ID:RESOURCE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeTargetGroupsOutput" %}}
