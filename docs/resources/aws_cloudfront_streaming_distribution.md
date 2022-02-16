---
title: About the aws_cloudfront_streaming_distribution Resource
platform: aws
---

# aws_cloudfront_streaming_distribution

Use the `aws_cloudfront_streaming_distribution` InSpec audit resource to test properties of a single specific AWS CloudFront streaming distribution.

## Syntax

Ensure that the distribution exists.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      it { should exist }
    end

## Parameters

`id` _(required)_

The streaming distribution's ID.

For additional information, see the [AWS documentation on AWS CloudFront streaming distribution.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-streamingdistribution.html).

## Properties

| Property | Description |
| :---: | :--- |
| id | The streaming distribution's ID. |
| arn | The ARN (Amazon Resource Name) for the distribution. |
| status | The current status of the RTMP distribution. |
| last_modified_time | The date and time that the distribution was last modified. |
| domain_name | The domain name that corresponds to the streaming distribution. |
| active_trusted_signers.enabled | This field is true if any of the accounts in the list have active CloudFront key pairs that CloudFront can use to verify the signatures of signed URLs and signed cookies. |
| active_trusted_signers.quantity | The number of accounts in the list. |
| active_trusted_signers.items | A list of accounts and the identifiers of active CloudFront key pairs in each account that CloudFront can use to verify the signatures of signed URLs and signed cookies. |
| active_aws_account_numbers | An account number that contains active CloudFront key pairs that CloudFront can use to verify the signatures of signed URLs and signed cookies. |
| active_key_pair_id_quantities | The number of key pair identifiers in the list. |
| active_key_pair_id_items | A list of CloudFront key pair identifiers. |
| streaming_distribution_config.caller_reference | A unique value (for example, a date-time stamp) that ensures that the request can't be replayed. |
| streaming_distribution_config.s3_origin.domain_name | The DNS name of the Amazon S3 origin. |
| streaming_distribution_config.s3_origin.origin_access_identity | The CloudFront origin access identity to associate with the distribution. Use an origin access identity to configure the distribution so that end users can only access objects in an Amazon S3 bucket through CloudFront. |
| streaming_distribution_config.aliases.quantity | The number of CNAME aliases, if any, that you want to associate with this distribution. |
| streaming_distribution_config.aliases.items | A complex type that contains the CNAME aliases, if any, that you want to associate with this distribution. |
| streaming_distribution_config.comment | Any comments you want to include about the streaming distribution. |
| streaming_distribution_config.logging.enabled | Specifies whether you want CloudFront to save access logs to an Amazon S3 bucket. |
| streaming_distribution_config.logging.bucket | The Amazon S3 bucket to store the access logs in. |
| streaming_distribution_config.logging.prefix | An optional string that you want CloudFront to prefix to the access log filenames for this streaming distribution. |
| streaming_distribution_config.trusted_signers.enabled | This field is true if any of the accounts have public keys that CloudFront can use to verify the signatures of signed URLs and signed cookies. If not, this field is false. |
| streaming_distribution_config.trusted_signers.quantity | The number of accounts in the list. |
| streaming_distribution_config.trusted_signers.items | A list of account identifiers. |
| streaming_distribution_config.price_class | A complex type that contains information about price class for this streaming distribution. |
| streaming_distribution_config.enabled | Whether the streaming distribution is enabled to accept user requests for content. |

## Examples

### Ensure an ID is available.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      its('id') { should eq 'ID' }
    end

### Ensure a status is `Deployed`.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
        its('status') { should eq 'Deployed' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetStreamingDistributionResult` action with `Effect` set to `Allow`.
