+++
title = "aws_s3_access_points Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_s3_access_points"
identifier = "inspec/resources/aws/aws_s3_access_points Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_s3_access_points` InSpec audit resource to test properties of a Multiple specific S3 bucket points resource.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS S3 Access Points.](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketMetricsConfiguration.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the base path mapping exists.

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
  it { should exist }
end
```

## Parameters

`bucket_name` _(required)_

: The name of the bucket containing the metrics configuration to retrieve.

## Properties

`ids`
: The ID used to identify the metrics configuration.

: **Field**: `id`

`filter_access_point_arns`
: The access point ARN used when evaluating a metrics filter.

: **Field**: `filter.access_point_arn`

`filter_and_access_point_arns`
: The access point ARN used when evaluating an AND predicate.

: **Field**: `filter.and.access_point_arn`

## Examples

**Ensure that an ID is available.**

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
    its('ids') { should include 'AccessPointArn' }
end
```

**Ensure that stage name is available.**

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
    its('filter_access_point_arns') { should include 'AccessPointArn' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_s3_access_points(bucket_name: 'BUCKET_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="S3:Client:listBucketMetricsConfigurationOutput" %}}
