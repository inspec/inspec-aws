+++
title = "aws_s3_access_point Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_s3_access_point"
identifier = "inspec/resources/aws/aws_s3_access_point Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_s3_access_point` InSpec audit resource to test properties of a single specific S3 bucket resource.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS API Metric.](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketMetricsConfiguration.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the base path mapping exists.

```ruby
describe aws_s3_access_point(bucket_name: 'BUCKET_NAME', metrics_id: 'METRICS_ID') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_

: The name of the bucket containing the metrics configuration to retrieve.

`metrics_id` _(required)_

: The ID used to identify the metrics configuration.

## Properties

`id`
: The ID used to identify the metrics configuration.

: **Field**: `id`

`filter.access_point_arn`
: The access point ARN used when evaluating a metrics filter.

: **Field**: `filter.access_point_arn`

`filter.and.access_point_arn`
: The access point ARN used when evaluating an AND predicate.

: **Field**: `filter.and.access_point_arn`

## Examples

**Ensure that the id is available.**

```ruby
describe aws_s3_access_point(bucket_name:  'BUCKET_NAME', metrics_id: 'METRICS_ID') do
    its('id') { should eq 'METRICS_ID' }
end
```

**Ensure that access point arn is available.**

```ruby
describe aws_s3_access_point(bucket_name:  'BUCKET_NAME', metrics_id: 'METRICS_ID') do
    its('filter.access_point_arn') { should eq 'AccessPointArn' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_s3_access_point(bucket_name:  'BUCKET_NAME', metrics_id: 'METRICS_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_s3_access_point(bucket_name: 'dummy', metrics_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_s3_access_point(bucket_name: 'BUCKET_NAME', metrics_id: 'METRICS_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% aws_permissions_principal action="S3:Client:GetBucketMetricsConfigurationOutput" %}}
