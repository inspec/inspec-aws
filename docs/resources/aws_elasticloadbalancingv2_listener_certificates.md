---
title: About the aws_elasticloadbalancingv2_listener_certificates Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_certificates

Use the `aws_elasticloadbalancingv2_listener_certificates` InSpec audit resource to test properties of multiple TLS or HTTPS listener certificates.

## Syntax

Ensure that a listener ARN exists.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

## Parameters

### listener_arn _(required)_

The Amazon Resource Name (ARN) of the listener certificate.

See also the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Properties

|Property | Description|
| --- | --- |
| certificate_arns | The Amazon Resource Name (ARN) of the certificate. |
| is_default | Indicates whether the certificate is the default certificate.  |

## Examples

### Ensure a listener ARN is available.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

### Ensure that listener has a desired certificate ARN attached.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
      its('certificate_arns') { should include "CERTIFICATE_ARN" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticLoadBalancingV2:Client:DescribeListenerCertificatesOutput` action with `Effect` set to `Allow`.
