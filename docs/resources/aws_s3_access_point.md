---
title: About the aws_s3_access_point Resource
platform: aws
---

# aws_s3_access_point

Use the `aws_s3_access_point` InSpec audit resource to test properties of a single specific S3 bucket resource.

## Syntax

Ensure that the base path mapping exists.

    describe aws_s3_access_point(bucket: 'Bucket', id: 'ID') do
      it { should exist }
    end

## Parameters

`domain_name base_path` _(required)_

| Property | Description |
| --- | --- |
| bucket | The name of the bucket containing the metrics configuration to retrieve. |
| id | The ID used to identify the metrics configuration. |

For additional information, see the [AWS documentation on AWS API Metric.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| access_point_arn | The access point ARN used when evaluating an AND predicate.| access_point_arn |


## Example

### Ensure that stage name is available.
    describe aws_s3_access_point(bucket: 'Bucket', id: 'ID') do
        its('access_point_arn') { should eq 'AccessPointArn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_access_point(bucket: 'Bucket', id: 'ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_access_point(bucket: 'Bucket', id: 'ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_access_point(bucket: 'Bucket', id: 'ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:GetBucketMetricsConfigurationOutput` action with `Effect` set to `Allow`.