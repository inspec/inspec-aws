---
title: About the aws_elasticloadbalancingv2_listener_certificate Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_certificate

Use the `aws_elasticloadbalancingv2_listener_certificate` InSpec audit resource to test properties of a single TLS or HTTPS listener certificate.

## Syntax

Ensure that a listener ARN exist.

    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

Ensure that the listener has a desired port.

    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
      its('certificate_arn') { should eq "CERTIFICATE_ARN" }
    end

### Parameters

#### listener_arn _(required)_

The Amazon Resource Name (ARN) of the listener certificate.

See also the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Properties

|Property | Description|
| --- | --- |
| certificate_arn | The Amazon Resource Name (ARN) of the certificate. |
| is_default | Indicates whether the certificate is the default certificate. Valid values: `true` or `false`. |

## Examples

### Ensure that a listener ARN exists.

    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

### Ensure that listener has a desired certificate ARN attached.

    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
      its('certificate_arn') { should eq "CERTIFICATE_ARN" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
       it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticLoadBalancingV2:Client:DescribeListenerCertificatesOutput` actions with Effect set to Allow.

