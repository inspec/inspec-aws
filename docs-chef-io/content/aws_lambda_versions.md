+++
title = "aws_lambda_versions resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_versions"
identifier = "inspec/resources/aws/aws_lambda_versions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_versions` InSpec audit resource to test properties of multiple AWS Lambda function versions.

The `AWS::Lambda::Version` resource creates a version from the current code and configuration of a function. Use versions to create a snapshot of your function code and configuration that doesn't change.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version.html).

## Syntax

Ensure that a Lambda version exists.

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  it { should exist }
end
```

## Parameters

`layer_name` _(required)_

: The name or Amazon Resource Name (ARN) of the Lambda layer.

## Properties

`layer_version_arns`
: The ARN of the layer version.

: **Field**: `layer_version_arn`

`versions`
: The version number.

: **Field**: `version`

`descriptions`
: The description of the version.

: **Field**: `description`

`created_dates`
: The date that the layer version was created, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD).

: **Field**: `created_date`

`compatible_runtimes`
: The layer's compatible runtimes.

: **Field**: `compatible_runtimes`

`license_infos`
: The layer's software license.

: **Field**: `license_info`

`compatible_architectures`
: A list of compatible instruction set architectures .

: **Field**: `compatible_architectures`

## Examples

Ensure a layer version ARN is available:

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  its('layer_version_arns') { should include 'LAYER_VERSION_ARN' }
end
```

Ensure a version is available:

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  its('versions') { should include 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListLayerVersionsResponse" %}}
