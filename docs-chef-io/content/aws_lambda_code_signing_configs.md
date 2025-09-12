+++
title = "aws_lambda_code_signing_configs resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_code_signing_configs"
identifier = "inspec/resources/aws/aws_lambda_code_signing_configs resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_code_signing_configs` InSpec audit resource to test properties of multiple AWS Lambda code signing configurations.

The `AWS::Lambda::CodeSigningConfig` resource specifies the details about a code signing configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM CodeSigningConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-codesigningconfig.html).

## Syntax

Ensure that the code signing config exists.

```ruby
describe aws_lambda_code_signing_configs do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`code_signing_config_ids`
: Unique identifier for the Code signing configuration.

: **Field**: `code_signing_config_id`

`code_signing_config_arns`
: The Amazon Resource Name (ARN) of the Code signing configuration.

: **Field**: `code_signing_config_arn`

`descriptions`
: Code signing configuration description.

: **Field**: `description`

`allowed_publishers`
: The Amazon Resource Name (ARN) for each of the signing profiles. A signing profile defines a trusted user who can sign a code package.

: **Field**: `allowed_publishers`

`code_signing_policies`
: Code signing configuration policy for deployment validation failure.

: **Field**: `code_signing_policies`

`last_modified`
: The date and time that the Code signing configuration was last modified, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD).

: **Field**: `last_modified`

## Examples

**Ensure a code signing config id is available.**

```ruby
describe aws_lambda_code_signing_configs do
  its('code_signing_config_ids') { should include 'CODE_SIGNING_CONFIG_ID' }
end
```

**Ensure a code signing config arn is available.**

```ruby
describe aws_lambda_code_signing_configs do
  its('code_signing_config_arns') { should include 'CODE_SIGNING_CONFIG_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_code_signing_configs do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_code_signing_configs do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_code_signing_configs do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListCodeSigningConfigsResponse" %}}
