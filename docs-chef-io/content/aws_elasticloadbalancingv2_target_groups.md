+++
title = "aws_elasticloadbalancingv2_target_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticloadbalancingv2_target_groups"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_target_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_target_groups` InSpec audit resource to test properties of multiple Elastic Load Balancing V2 target groups.

## Syntax

Ensure that a target group arn exists.

```ruby
describe aws_elasticloadbalancingv2_target_groups  do
  it { should exist }
end
```

For additional information, see the [AWS documentation on ElasticLoadBalancingV2 TargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html).

## Properties

`target_group_arns`
: The Amazon Resource Name (ARN) of the target group.

`target_group_names`
: The name of the target group.

`protocols`
: The protocol to use for routing traffic to the targets. Valid values are: `GENEVE`, `HTTP`, `HTTPS`, `TCP`, `TCP_UDP`, `TLS`, or `UDP`.

`ports`
: The port on which the targets are listening. Not used if the target is a Lambda function.

`vpc_id s`
: The ID of the VPC for the targets.

`health_check_protocols`
: The protocol to use to connect with the target. The `GENEVE`, `TLS`, `UDP`, and `TCP_UDP` protocols are not supported for health checks.

`health_check_ports`
: The port to use to connect with the target.

`health_check_enableds`
: Indicates whether health checks are enabled.

`health_check_interval_seconds`
: The approximate amount of time, in seconds, between health checks of an individual target.

`health_check_timeout_seconds`
: The amount of time, in seconds, during which no response means a failed health check.

`healthy_threshold_counts`
: The number of consecutive health check successes required before considering an unhealthy target healthy.

`unhealthy_threshold_counts`
: The number of consecutive health check failures required before considering the target unhealthy.

`health_check_paths`
: The destination for health checks on the targets.

`matchers`
: The HTTP or gRPC codes to use when checking for a successful response from a target.

`load_balancer_arns`
: The Amazon Resource Names (ARN) of the load balancers that route traffic to this target group.

`target_types`
: The type of target that you must specify when registering targets with this target group. The possible values are instance (register targets by instance ID), ip (register targets by IP address), or lambda (register a single Lambda function as a target).

`protocol_versions`
: For HTTP or HTTPS protocols, the protocol version. Valid values are `GRPC`, `HTTP1`, and `HTTP2`.

## Examples

Ensure a target group ARN is available:

```ruby
describe aws_elasticloadbalancingv2_target_groups  do
  its('target_group_names') { should include 'TARGET_GROUP_NAME' }
end
```

Ensure that the target group name exists:

```ruby
describe aws_elasticloadbalancingv2_target_groups  do
    its('protocol_versions') { should include 'HTTP1' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticloadbalancingv2_target_groups  do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticloadbalancingv2_target_groups do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_elasticloadbalancingv2_target_groups  do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeTargetGroupsOutput" %}}
