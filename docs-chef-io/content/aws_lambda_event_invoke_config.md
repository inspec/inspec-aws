+++
title = "aws_lambda_event_invoke_config resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_event_invoke_config"
identifier = "inspec/resources/aws/aws_lambda_event_invoke_config resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_event_invoke_config` InSpec audit resource to test properties of a specific AWS Lambda EventInvokeConfig.

The AWS::Lambda::EventInvokeConfig resource configures options for asynchronous invocation on a version or an alias.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda EventInvokeConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventinvokeconfig.html).

## Syntax

Ensure that the config exists.

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

## Parameters

`function_name` _(required)_

: The name of the function.

## Properties

`last_modified`
: The date and time that the configuration was last updated.

: **Field**: `last_modified`

`function_arn`
: The Amazon Resource Name (ARN) of the function.

: **Field**: `function_arn`

`maximum_retry_attempts`
: The maximum number of times to retry when the function returns an error.

: **Field**: `maximum_retry_attempts`

`maximum_event_age_in_seconds`
: The maximum age of a request that Lambda sends to a function for processing.

: **Field**: `maximum_event_age_in_seconds`

`on_success_destinations`
: The destination configuration for successful invocations. The Amazon Resource Name (ARN) of the destination resource.

: **Field**: `destination_config (on_success (destination))`

`on_faliure_destinations`
: The destination configuration for failed invocations. The Amazon Resource Name (ARN) of the destination resource.

: **Field**: `destination_config (on_failure (destination))`

## Examples

**Ensure an arn is available.**

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
  its('function_arn') { should eq 'FUNCTION_ARN' }
end
```

**Ensure a maximum retry attempts is available.**

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
    its('maximum_retry_attempts') { should eq 1 }
end
```

**Ensure on success destination is available.**

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
    its('on_success_destinations') { should include 'DESTINATION' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:FunctionEventInvokeConfig" %}}
