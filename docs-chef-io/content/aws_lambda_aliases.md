+++
title = "aws_lambda_aliases resource"

draft = false


[menu.aws]
title = "aws_lambda_aliases"
identifier = "inspec/resources/aws/aws_lambda_aliases resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_aliases` InSpec audit resource to test properties of multiple AWS Lambda aliases.

The `AWS::Lambda::Alias` resource creates an alias for a Lambda function version. Use aliases to provide clients with a function identifier that you can update to invoke a different version.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias.html).

## Syntax

Ensure that the alias exists.

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

## Parameters

`function_name` _(required)_

: The name of the lambda function.

## Properties

`alias_arns`
: Lambda function ARN that is qualified using the alias name as the suffix.

: **Field**: `alias_arn`

`names`
: The alias names.

: **Field**: `name`

`function_versions`
: Function version to which the alias points.

: **Field**: `function_version`

`descriptions`
: The alias descriptions.

: **Field**: `description`

`routing_configs`
: Specifies an additional function versions the alias points to, allowing you to dictate what percentage of traffic will invoke each version.

: **Field**: `routing_config`

`revision_ids`
: Represents the latest updated revision of the function or alias.

: **Field**: `revision_id`

## Examples

Ensure an alias ARN is available:

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  its('alias_arns') { should include 'ALIAS_ARN' }
end
```

Ensure an alias name is available:

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  its('names') { should include 'FUNCTION_ALIAS_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListAliasesResponse" %}}
