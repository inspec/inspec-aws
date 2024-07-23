+++
title = "aws_elasticloadbalancingv2_listeners Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_elasticloadbalancingv2_listeners"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listeners Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listeners` InSpec audit resource to test the properties of multiple Application Load Balancer or Network Load Balancer listeners.

For additional information, including details on parameters and properties, see the [AWS documentation on ElasticLoadBalancingV2 Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_elasticloadbalancingv2_listeners` resource block returns all Application Load Balancer or Network Load Balancer listeners.

```ruby
describe aws_elasticloadbalancingv2_listener(load_balancer_arn: "LOAD_BALANCER_ARN") do
  its { should exist }
end
```

## Parameters

`load_balancer_arn` _(required)_

: The Amazon Resource Name (ARN) of the load balancer.

## Properties

`listener_arns`
: The Amazon Resource Name (ARN) of the listener.

`load_balancer_arns`
: The Amazon Resource Name (ARN) of the load balancer.

`ports`
: The port on which the load balancer is listening.

`protocols`
: The protocol for connections from clients to the load balancer.

`certificates`
: The certificates of the listener.

`ssl_policies`
: The SSL policies of the listener.

`default_actions`
: The default actions of the listener.

`alpn_policies`
: The name of the Application-Layer Protocol Negotiation (ALPN) policies of the listener.

## Examples

**Ensure there are ports attached to the listener.**

```ruby
describe aws_elasticloadbalancingv2_listener(load_balancer_arn: "LOAD_BALANCER_ARN") do
    its('ports') { should include PORT_NUMBER}
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_elasticloadbalancingv2_listener(load_balancer_arn: "LOAD_BALANCER_ARN") do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeListenersOutput" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).
