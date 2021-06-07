---
title: About the aws_elasticloadbalancingv2_listener_certificate Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_certificate

Use the `aws_elasticloadbalancingv2_listener_certificate` InSpec audit resource to test properties of a single AWS ElasticLoadBalancingV2 Listener Certificate. 

## Syntax

Ensure that a listener arn exist.
    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'test') do
      it { should exist }
    end

Ensure that the listener has a desired port.
    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'test') do
      its('certificate_arn') { should eq "test" }
    end

#### Parameters

##### listener_arn _(required)_

See also the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Properties

|Property | Description|
| --- | --- |
|certificate_arn | The Amazon Resource Name (ARN) of the certificate. |
| is_default | Indicates whether the certificate is the default certificate. Do not set this value when specifying a certificate as an input. This value is not included in the output when describing a listener, but is included when describing listener certificates. |

## Examples

##### Ensure that a listerner_arn exists
    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'test') do
      it { should exist }
    end
    
##### Ensure that listerner has a desired certificate arn attached.
    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'test') do
      its('certificate_arn') { should eq "test" }
    end
   
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_elasticloadbalancingv2_listener(listener_arn: "dummy") do
       it { should_not exist }
    end  

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_listener_certificates` actions with Effect set to Allow.  

