+++
title = "aws_lambda_event_invoke_configs resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_event_invoke_configs"
identifier = "inspec/resources/aws/aws_lambda_event_invoke_configs resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_event_invoke_configs` InSpec audit resource to test properties of the plural resource of AWS Lambda EventInvokeConfig.

The AWS::Lambda::EventInvokeConfig resource configures options for asynchronous invocation on a version or an alias.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda EventInvokeConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventinvokeconfig.html).

## Syntax

Ensure that the config exists.

```ruby
describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
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

`function_arns`
: The Amazon Resource Name (ARN) of the function.

: **Field**: `function_arn`

`maximum_retry_attempts`
: The maximum number of times to retry when the function returns an error.

: **Field**: `maximum_retry_attempts`

`destination_configs`
: A destination for events after they have been sent to a function for processing.

: **Field**: `destination_configs`

## Examples

**Ensure an arn is available.**

```ruby
describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
  its('function_arns') { should include 'FUNCTION_ARN' }
end
```

**Ensure a maximum retry attempts is available.**

```ruby
describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
    its('maximum_retry_attempts') { should include 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListFunctionEventInvokeConfigsResponse" %}}
