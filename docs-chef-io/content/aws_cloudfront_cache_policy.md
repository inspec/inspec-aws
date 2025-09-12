+++
title = "aws_cloudfront_cache_policy resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudfront_cache_policy"
identifier = "inspec/resources/aws/aws_cloudfront_cache_policy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_cache_policy` InSpec audit resource to test properties of a single specific AWS CloudFront cache policy.

The `AWS::CloudFront::CachePolicy` resource describes the CloudFront cache policy.

## Syntax

Ensure that the custom resource exists.

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
  it { should exist }
end
```

## Parameters

`id` _(required)_

: The unique identifier for the cache policy.

  For additional information, see the [AWS CloudFormation cache policy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-cloudfront-cachepolicy.html).

## Properties

`id`
: The unique identifier for the cache policy.

`last_modified_time`
: The date and time when the cache policy was last modified.

`cache_policy_config.comment`
: A comment to describe the cache policy.

`cache_policy_config.name`
: A unique name to identify the cache policy.

`cache_policy_config.default_ttl`
: The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

`cache_policy_config.max_ttl`
: The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

`cache_policy_config.min_ttl`
: The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_gzip`
: A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_brotli`
: A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.header_behavior`
: Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.headers.quantity`
: The number of header names in the Items list.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.headers.items`
: A list of HTTP header names.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookie_behavior`
: Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookies.quantity`
: The number of cookie names in the Items list.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookies.items`
: A list of cookie names.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_string_behavior`
: Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_strings.quantity`
: The number of query string names in the Items list.

`cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_strings.items`
: A list of query string names.

## Examples

**Ensure a ID is available.**

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
  its('id') { should eq 'ID' }
end
```

**Verify the max TTL of the policy.**

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
    its('cache_policy_config.max_ttl') { should eq 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudfront_cache_policy(id: 'ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:GetCachePolicyResult" %}}
