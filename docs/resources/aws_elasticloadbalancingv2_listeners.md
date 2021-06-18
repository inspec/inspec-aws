---
title: About the aws_elasticloadbalancingv2_listeners Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listeners

Use the `aws_elasticloadbalancingv2_listeners` InSpec audit resource to test the properties of a collection of AWS ElasticLoadBalancingV2 Listeners.

## Syntax

An `aws_elasticloadbalancingv2_listeners` resource block returns all ElasticLoadBalancingV2 Listeners.
    describe aaws_elasticloadbalancingv2_listeners(load_balancer_arn: 'test_lb_arn') do
      its { should exist }
    end
    
#### Parameters

##### load_balancer_arn _(required)_

See also the [AWS documentation on ElasticLoadBalancingV2 Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html).

## Properties

|Property | Description|
| --- | --- |
|listener_arns | The Amazon Resource Name (ARN) of the listener. |
|load_balancer_arns | The Amazon Resource Name (ARN) of the load balancer. |
|ports | The port on which the load balancer is listening. |
|protocols | The protocol for connections from clients to the load balancer. |
|certificates | The certificates of the listener. |
|ssl_policies | The ssl policies of the listener. |
|default_actions | The default actions of the listener. |
|alpn_policies | The alpn policies of the listener. |

## Examples

##### Ensure there are ports attached to the listener.
    describe aaws_elasticloadbalancingv2_listeners(load_balancer_arn: 'test_lb_arn') do
        its('ports') { should include 80}
      end

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    aws_elasticloadbalancingv2_listeners(load_balancer_arn: 'test_lb_arn') do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:Describe*` actions with Effect set to Allow.  
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).
