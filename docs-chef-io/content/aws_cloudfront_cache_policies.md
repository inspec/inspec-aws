+++
title = "aws_cloudfront_cache_policies resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudfront_cache_policies"
identifier = "inspec/resources/aws/aws_cloudfront_cache_policies resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_cache_policies` InSpec audit resource to test properties of multiple AWS CloudFront cache policies.

The `AWS::CloudFront::CachePolicy` resource describes the CloudFront cache policy.

## Syntax

Ensure that the custom resource exists.

```ruby
describe aws_cloudfront_cache_policies do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`types`
: The type for the cache policy.

: **Field**: `type`

`ids`
: The unique identifier for the cache policy.

: **Field**: `id`

`last_modified_times`
: The date and time when the cache policy was last modified.

: **Field**: `last_modified_time`

`comments`
: A comment to describe the cache policy.

: **Field**: `comment`

`names`
: A unique name to identify the cache policy.

: **Field**: `name`

`default_ttls`
: The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

: **Field**: `default_ttl`

`max_ttls`
: The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

: **Field**: `max_ttl`

`min_ttls`
: The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.

: **Field**: `min_ttl`

## Examples

**Test that an ID is available.**

```ruby
describe aws_cloudfront_cache_policies do
  its('ids') { should include 'ID' }
end
```

**Verify the maximum TTL of the policy.**

```ruby
describe aws_cloudfront_cache_policies do
    its('max_ttls') { should include 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_cache_policies do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_cache_policies do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListCachePoliciesResult" %}}
