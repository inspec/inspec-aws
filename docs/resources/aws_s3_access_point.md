---
title: About the aws_s3_access_point Resource
platform: aws
---

# aws_s3_access_point

Use the `aws_s3_access_point` InSpec audit resource to test properties of a single specific S3 bucket resource.

## Syntax

Ensure that the base path mapping exists.

    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
      it { should exist }
    end

## Parameters

`domain_name metrics_id` _(required)_

| Property | Description |
| --- | --- |
| bucket_name | The name of the bucket containing the metrics configuration to retrieve. |
| metrics_id | The ID used to identify the metrics configuration. |

For additional information, see the [AWS documentation on AWS API Metric.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| id | The ID used to identify the metrics configuration. | id |
| filter.prefix | The prefix used when evaluating a metrics filter. | filter.prefix |
| filter.tag | The tag used when evaluating a metrics filter. | filter.tag |
| filter.access_point_arn | The access point ARN used when evaluating a metrics filter. | filter.access_point_arn |
| filter.and.prefix | The prefix used when evaluating an AND predicate. | filter.and.prefix |
| filter.and.tags | The list of tags used when evaluating an AND predicate. | filter.and.tags |
| filter.and.access_point_arn | The access point ARN used when evaluating an AND predicate. | filter.and.access_point_arn |

## Example

### Ensure that the id is available.
    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
        its('id') { should eq 'MetricsId' }
    end

### Ensure that access point arn is available.
    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
        its('filter.access_point_arn') { should eq 'AccessPointArn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_access_point(bucket_name: 'dummy', metrics_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:GetBucketMetricsConfigurationOutput` action with `Effect` set to `Allow`.