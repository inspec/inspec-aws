+++
title = "aws_cloudfront_distribution resource"

draft = false


[menu.aws]
title = "aws_cloudfront_distribution"
identifier = "inspec/resources/aws/aws_cloudfront_distribution resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_distribution` InSpec audit resource to test the properties of a single AWS CloudFront distribution.

For additional information, including details on parameters and properties, see the [AWS API reference for CloudFront distributions](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_distribution.html) documentation. For available SSL/TLS version identifiers, see [OriginSslProtocols](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_OriginSslProtocols.html) and [AWS::CloudFront::distribution ViewerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-viewercertificate.html) documentation.

## Syntax

Ensure that an `aws_cloudfront_distribution` exists:

```ruby
describe aws_cloudfront_distribution('DISTRIBUTION') do
  it { should exist }
end
```

```ruby
describe aws_cloudfront_distribution(distribution_id: 'DISTRIBUTION') do
  it { should exist }
end
```

## Parameters

`distribution_id` _(required)_

: The CloudFront distribution ID, which can be passed either as a string or as a `name: 'value'` key-value entry in a hash.

`disallowed_ssl_protocols` _(optional)_

: If provided, this parameter is expected to be an array of strings identifying SSL/TLS protocols that you wish not to allow.

: Included in the array should be the union of disallowed identifiers for:

: - custom origin SSL/TLS protocols (currently SSLv3 | TLSv1 | TLSv1.1 | TLSv1.2)

- identifiers for the minimum SSL/TLS protocol in the Viewer Certificate that CloudFront can use to communicate with viewers (currently SSLv3 | TLSv1 | TLSv1_1026 | TLSv1.1_2016 | TLSv1.2_2018 | TLSv1.2_2019 | TLSv1.2_2021).

: Newer protocol identification strings (when available) may be provided in the set, as validity is not checked. The default value for disallowed_ssl_protocols is `%w{SSLv3 TLSv1 TLSv1_2016}`.

`origin_domain_name` _(optional)_

: The domain name for the origin.

: Provide the `origin_domain_name` if you want to validate the `s3_origin_path` property.

## Properties

`distribution_id`
: The identifier for the CloudFront distribution.

`viewer_protocol_policies`
: An array of viewer protocol policies for all caches in this distribution; valid policy names are `allow-all` (which allows HTTP and HTTPS), `https-only` or `redirect-to-https`.

`custom_origin_ssl_protocols`
: An array containing SSL/TLS protocols allowed by custom origins in this distribution. Empty if there are no custom origins (one or more standard S3 bucket origins). Current valid values are `SSLv3`, `TLSv1`, `TLSv1.1`, `TLSv1.2`.

`viewer_certificate_minimum_ssl_protocol`
: The minimum SSL/TLS protocol version in the Viewer Certificate. Current valid values: `SSLv3`, `TLSv1`, `TLSv1_2016`, `TLSv1.1_2016`, `TLSv1.2_2018`, `TLSv1.2_2019`, `TLSv1.2_2021`.

`s3_origin_config`
: `True`: if there are any S3 origin configs in the distribution (i.e. standard S3 bucket origins), else `False`.

`s3_origin_path`
: The S3 origin path if `origin_domain_name` is specified in the resource parameters.

`s3_origin_access`
: The origin access identity for s3 origin config.

`access_logging`
: Access logging for CloudFront distribution.

`ssl_certificate`
: The viewer certificate certificate source of CloudFront distribution.

## Examples

Test that a CloudFront distribution has secure protocols configured:

```ruby
describe aws_cloudfront_distribution('DISTRIBUTION_ID') do
  its('viewer_certificate_minimum_ssl_protocol') { should_not match /SSLv3|TLSv1$|TLSv1_2016/ }
  its('viewer_protocol_policies') { should_not include 'allow-all' }
  {SSLv3 TLSv1}.each do |protocol|
    its('custom_origin_ssl_protocols') { should_not include protocol }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### have_viewer_protocol_policies_allowing_http

The `have_viewer_protocol_policies_allowing_http` matcher tests if any of the caches for origins, including the default cache, has its viewer_protocol_policy set to 'allow-all'.

```ruby
it { should_not have_viewer_protocol_policies_allowing_http }
```

### have_disallowed_custom_origin_ssl_protocols

The `have_disallowed_custom_origin_ssl_protocols` matcher tests whether any of the SSL/TLS protocols defined in the ssl_protocols for all custom origins in the distribution are present in the `disallowed_ssl_protocols` parameter (if provided), or in the default disallowed SSL/TLS protocol list (if not).

```ruby
it { should_not have_disallowed_custom_origin_ssl_protocols }
```

### have_disallowed_viewer_certificate_minimum_ssl_protocol

The `have_disallowed_viewer_minimum_ssl_protocol` matcher tests whether the minimum SSL/TLS protocol for the distribution's Viewer Certificate is in the `disallowed_ssl_protocols` parameter (if provided), or in the default disallowed SSL/TLS protocol list (if not).

```ruby
it { should_not have_disallowed_viewer_certificate_minimum_ssl_protocol }
```

### have_s3_origin_configs

The `have_s3_origin_configs` matcher tests whether the distribution has a non-nil s3_origin_configs setting in any of its origins.

```ruby
it { should_not have_s3_origin_configs }
```

### have_access_logging_enabled

The `have_access_logging_enabled` matcher tests whether the distribution has access logging enabled.

```ruby
it { should have_access_logging_enabled }
```

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_cloudfront_distribution('EXISTING_DISTRIBUTION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe cloudfront_distribution('NONEXISTING_DISTRIBUTION_ID') do
  it { should_not exist }
end
```

### s3_origin_path

Use `s3_origin_path` to return an origin path for the specified origin domain name if the origin path is configured, otherwise it returns an empty string.

```ruby
describe aws_cloudfront_distribution(distribution_id: 'DISTRIBUTION_ID', origin_domain_name: 'ORIGIN_DOMAIN_NAME') do
  its ('s3_origin_path') { should include '/next' }
end
```

```ruby
describe aws_cloudfront_distribution(distribution_id: 'DISTRIBUTION_ID', origin_domain_name: 'ORIGIN_DOMAIN_NAME') do
  its ('s3_origin_path') { should include '/release' }
end
```

For the default origin path:

```ruby
describe aws_cloudfront_distribution(distribution_id: 'DISTRIBUTION_ID', origin_domain_name: 'ORIGIN_DOMAIN_NAME') do
    its ('s3_origin_path') { should include '' }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:GetDistributionResult" %}}

You can find detailed documentation at [Identity and Access Management (IAM) in CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/auth-and-access-control.html).
