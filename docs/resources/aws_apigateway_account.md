---
title: About the aws_apigateway_account Resource
platform: aws
---

# aws_apigateway_account

Use the `aws_apigateway_account` InSpec audit resource to test properties of a single specific AWS API Gateway account.

The `AWS::ApiGateway::Account` resource specifies the IAM role that Amazon API Gateway uses to write API logs to Amazon CloudWatch Logs.

## Syntax

Ensure that the account exists.

    describe aws_apigateway_account do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS API Gateway accounts.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-account.html).

## Properties

| Property | Description |
| --- | --- |
| cloudwatch_role_arn | The ARN of an Amazon CloudWatch role for the current account. |
| throttle_settings.burst_limit | The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity. |
| throttle_settings.rate_limit | The API request steady-state rate limit. |
| features | A list of features supported for the account. When usage plans are enabled, the features list will include an entry of "UsagePlans". |
| api_key_version | The version of the API keys used for the account. |


## Examples

### Ensure a Cloudwatch role ARN is available.

    describe aws_apigateway_account do
      its('cloudwatch_role_arn') { should eq 'CloudWatchRoleARN' }
    end

### Ensure that the burst limit is `1`.

    describe aws_apigateway_account do
        its('throttle_settings.burst_limit') { should eq '1' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_account do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_account do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_account do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:Account` action with `Effect` set to `Allow`.
