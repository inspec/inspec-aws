---
title: About the aws_s3_access_points Resource
platform: aws
---

# aws_s3_access_points

Use the `aws_s3_access_points` InSpec audit resource to test properties of a Multiple specific S3 bucket points resource.

## Syntax

Ensure that the base path mapping exists.

    describe aws_s3_access_points(bucket: 'Bucket') do
      it { should exist }
    end

## Parameters

`bucket` _(required)_

| Property | Description |
| --- | --- |
| bucket | The name of the bucket containing the metrics configuration to retrieve. |


For additional information, see the [AWS documentation on AWS S3 Access Points.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| access_point_arn | The access point ARN.| access_point_arn |


## Example

### Ensure that stage name is available.
    describe aws_s3_access_points(bucket: 'Bucket') do
        its('access_point_arn') { should eq 'AccessPointArn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_access_points(bucket: 'Bucket') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_access_points(bucket: 'Bucket') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_access_points(bucket: 'Bucket') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:listBucketMetricsConfigurationOutput` action with `Effect` set to `Allow`.