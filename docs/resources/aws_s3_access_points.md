---
title: About the aws_s3_access_points Resource
platform: aws
---

# aws_s3_access_points

Use the `aws_s3_access_points` InSpec audit resource to test properties of a Multiple specific S3 bucket points resource.

## Syntax

Ensure that the base path mapping exists.

    describe aws_s3_access_points(bucket_name: 'BucketName') do
      it { should exist }
    end

## Parameters

`bucket_name` _(required)_

| Property | Description |
| --- | --- |
| bucket_name | The name of the bucket containing the metrics configuration to retrieve. |

For additional information, see the [AWS documentation on AWS S3 Access Points.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| ids | The ID used to identify the metrics configuration. | id |
| filter_prefixes | The prefix used when evaluating a metrics filter. | filter.prefix |
| filter_tags | The tag used when evaluating a metrics filter. | filter.tag |
| filter_access_point_arns | The access point ARN used when evaluating a metrics filter. | filter.access_point_arn |
| filter_and_prefixes | The prefix used when evaluating an AND predicate. | filter.and.prefix |
| filter_and_tags | The list of tags used when evaluating an AND predicate. | filter.and.tags |
| filter_and_access_point_arns | The access point ARN used when evaluating an AND predicate. | filter.and.access_point_arn |

## Example

### Ensure that id is available.
    describe aws_s3_access_points(bucket_name: 'BucketName') do
        its('ids') { should include 'AccessPointArn' }
    end

### Ensure that stage name is available.
    describe aws_s3_access_points(bucket_name: 'BucketName') do
        its('filter_access_point_arn') { should include 'AccessPointArn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_access_points(bucket_name: 'BucketName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_access_points(bucket_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_access_points(bucket_name: 'BucketName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:listBucketMetricsConfigurationOutput` action with `Effect` set to `Allow`.