+++
title = "aws_lambda_code_signing_config Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_lambda_code_signing_config"
identifier = "inspec/resources/aws/aws_lambda_code_signing_config Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_code_signing_config` InSpec audit resource to test properties of a single AWS Lambda code signing configuration.

The `AWS::Lambda::CodeSigningConfig` resource specifies the details about a code signing configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM CodeSigningConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-codesigningconfig.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the code signing config exists.

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  it { should exist }
end
```

## Parameters

`code_signing_config_arn` _(required)_

: The Amazon Resource Name (ARN) of the code signing configuration.

## Properties

`code_signing_config_id`
: Unique identifier for the Code signing configuration.

`code_signing_config_arn`
: The Amazon Resource Name (ARN) of the Code signing configuration.

`description`
: Code signing configuration description.

`allowed_publishers.signing_profile_version_arns`
: The Amazon Resource Name (ARN) for each of the signing profiles. A signing profile defines a trusted user who can sign a code package.

`code_signing_policies.untrusted_artifact_on_deployment`
: Code signing configuration policy for deployment validation failure.

`last_modified`
: The date and time that the Code signing configuration was last modified, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD).

## Examples

**Ensure a code signing config ID is available.**

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  its('code_signing_config_id') { should eq 'CODE_SIGNING_CONFIG_ID' }
end
```

**Ensure a code signing config ARN is available.**

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  its('code_signing_config_arn') { should eq 'CODE_SIGNING_CONFIG_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:GetCodeSigningConfigResponse" %}}
