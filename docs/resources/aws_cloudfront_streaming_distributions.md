---
title: About the aws_cloudfront_streaming_distributions Resource
platform: aws
---

# aws_cloudfront_streaming_distributions

Use the `aws_cloudfront_streaming_distributions` InSpec audit resource to test plural properties of AWS CloudFront streaming distribution.

## Syntax

Ensure that the distribution exists.

    describe aws_cloudfront_streaming_distributions do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront streaming distribution.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-streamingdistribution.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| ids | The streaming distribution's ID. | id |
| arns | The ARN (Amazon Resource Name) for the distribution. | arn |
| statuses | The current status of the RTMP distribution. | status |
| last_modified_time | The date and time that the distribution was last modified. | last_modified_time |
| domain_names | The domain name corresponding to the distribution. | domain_names |
| s3_origins | A complex type that contains information about the Amazon S3 bucket from which you want CloudFront to get your media files for distribution. | s3_origin |
| aliases | A complex type that contains information about CNAMEs (alternate domain names), if any, for this streaming distribution. | aliases |
| trusted_signers | A complex type that specifies the accounts. | trusted_signers |
| comments | The comment originally specified when this distribution was created. | comment |
| price_classes | A complex type that contains information about price class for this streaming distribution. | price_class |
| enabled | Whether the distribution is enabled to accept end user requests for content. | enabled |

## Examples

### Ensure an ID is available.

    describe aws_cloudfront_streaming_distributions do
      its('ids') { should include 'ID' }
    end

### Ensure a status is `Deployed`.

    describe aws_cloudfront_streaming_distributions do
        its('statuses') { should include 'Deployed' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_streaming_distributions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_streaming_distributions do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListStreamingDistributionsResult` action with `Effect` set to `Allow`.
