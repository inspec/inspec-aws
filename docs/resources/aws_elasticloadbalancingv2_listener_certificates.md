---
title: About the aws_elasticloadbalancingv2_listener_certificates Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_certificates

Use the `aws_elasticloadbalancingv2_listener_certificates` InSpec audit resource to test properties of a plural AWS ElasticLoadBalancingV2 Listener Certificates.

## Syntax

Ensure that a listener_arn exists.
    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      it { should exist }
    end

## Parameters

##### listener_arn _(required)_

See also the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Properties

|Property | Description|
| --- | --- |
| certificate_arn | The Amazon Resource Name (ARN) of the certificate. |
| is_default | Indicates whether the certificate is the default certificate. Do not set this value when specifying a certificate as an input. This value is not included in the output when describing a listener, but is included when describing listener certificates. |

## Examples

### Ensure a listener_arn is available.
    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      it { should exist }
    end


##### Ensure that listerner has a desired certificate arn attached.
    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      its('certificate_arns') { should eq "test" }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'dummy') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_listener_certificates` action with `Effect` set to `Allow`.