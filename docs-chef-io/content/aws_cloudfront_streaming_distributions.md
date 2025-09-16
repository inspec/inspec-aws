+++
title = "aws_cloudfront_streaming_distributions resource"

draft = false


[menu.aws]
title = "aws_cloudfront_streaming_distributions"
identifier = "inspec/resources/aws/aws_cloudfront_streaming_distributions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_streaming_distributions` InSpec audit resource to test plural properties of AWS CloudFront streaming distribution.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront streaming distribution.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-streamingdistribution.html).

## Syntax

Ensure that the distribution exists.

```ruby
describe aws_cloudfront_streaming_distributions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The streaming distribution's ID.

: **Field**: `id`

`arns`
: The ARN (Amazon Resource Name) for the distribution.

: **Field**: `arn`

`statuses`
: The current status of the RTMP distribution.

: **Field**: `status`

`last_modified_time`
: The date and time that the distribution was last modified.

: **Field**: `last_modified_time`

`domain_names`
: The domain name corresponding to the distribution.

: **Field**: `domain_names`

`s3_origins`
: A complex type that contains information about the Amazon S3 bucket from which you want CloudFront to get your media files for distribution.

: **Field**: `s3_origin`

`aliases`
: A complex type that contains information about CNAMEs (alternate domain names), if any, for this streaming distribution.

: **Field**: `aliases`

`trusted_signers`
: A complex type that specifies the accounts.

: **Field**: `trusted_signers`

`comments`
: The comment originally specified when this distribution was created.

: **Field**: `comment`

`price_classes`
: A complex type that contains information about price class for this streaming distribution.

: **Field**: `price_class`

`enabled`
: Whether the distribution is enabled to accept end user requests for content.

: **Field**: `enabled`

## Examples

Ensure an ID is available:

```ruby
describe aws_cloudfront_streaming_distributions do
  its('ids') { should include 'ID' }
end
```

Ensure a status is `Deployed`:

```ruby
describe aws_cloudfront_streaming_distributions do
    its('statuses') { should include 'Deployed' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_streaming_distributions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_streaming_distributions do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListStreamingDistributionsResult" %}}
