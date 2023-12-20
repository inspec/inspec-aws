+++
title = "aws_apigateway_account Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_apigateway_account"
identifier = "inspec/resources/aws/aws_apigateway_account Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_account` InSpec audit resource to test properties of a single specific AWS API Gateway account.

The `AWS::ApiGateway::Account` resource specifies the IAM role that Amazon API Gateway uses to write API logs to Amazon CloudWatch Logs.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS API Gateway accounts.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-account.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the account exists.

```ruby
describe aws_apigateway_account do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`cloudwatch_role_arn`
: The ARN of an Amazon CloudWatch role for the current account.

`throttle_settings.burst_limit`
: The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity.

`throttle_settings.rate_limit`
: The API request steady-state rate limit.

`features`
: A list of features supported for the account. When usage plans are enabled, the features list will include an entry of "UsagePlans".

`api_key_version`
: The version of the API keys used for the account.

## Examples

**Ensure a Cloudwatch role ARN is available.**

```ruby
describe aws_apigateway_account do
  its('cloudwatch_role_arn') { should eq 'CloudWatchRoleARN' }
end
```

**Ensure that the burst limit is `1`.**

```ruby
describe aws_apigateway_account do
    its('throttle_settings.burst_limit') { should eq '1' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_account do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_account do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_apigateway_account do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Account" %}}
