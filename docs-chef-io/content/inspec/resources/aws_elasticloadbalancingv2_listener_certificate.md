+++
title = "aws_elasticloadbalancingv2_listener_certificate Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_elasticloadbalancingv2_listener_certificate"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listener_certificate Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listener_certificate` InSpec audit resource to test properties of a single TLS or HTTPS listener certificate.

For additional information, including details on parameters and properties, see the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a listener ARN exist.

```ruby
describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

Ensure that the listener has a desired port.

```ruby
describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
  its('certificate_arn') { should eq "CERTIFICATE_ARN" }
end
```

## Parameters

`listener_arn` _(required)_

: The Amazon Resource Name (ARN) of the listener certificate.

## Properties

`certificate_arn`
: The Amazon Resource Name (ARN) of the certificate.

`is_default`
: Indicates whether the certificate is the default certificate. Valid values: `true` or `false`.

## Examples

**Ensure that a listener ARN exists.**

```ruby
describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

**Ensure that listener has a desired certificate ARN attached.**

```ruby
describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'LISTENER_ARN') do
  its('certificate_arn') { should eq "CERTIFICATE_ARN" }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_elasticloadbalancingv2_listener(listener_arn: "LISTENER_ARN") do
   it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeListenerCertificatesOutput" %}}

