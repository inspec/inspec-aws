+++
title = "aws_elasticloadbalancingv2_listener_certificates resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticloadbalancingv2_listener_certificates"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listener_certificates resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listener_certificates` InSpec audit resource to test properties of multiple TLS or HTTPS listener certificates.

For additional information, including details on parameters and properties, see the [AWS documentation on ElasticLoadBalancingV2 Listener Certificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html).

## Syntax

Ensure that a listener ARN exists.

```ruby
describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

## Parameters

`listener_arn` _(required)_

: The Amazon Resource Name (ARN) of the listener certificate.

## Properties

`certificate_arns`
: The Amazon Resource Name (ARN) of the certificate.

`is_default`
: Indicates whether the certificate is the default certificate.

## Examples

Ensure a listener ARN is available:

```ruby
describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

Ensure that listener has a desired certificate ARN attached:

```ruby
describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
  its('certificate_arns') { should include "CERTIFICATE_ARN" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'LISTENER_ARN') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeListenerCertificatesOutput" %}}
