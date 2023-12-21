+++
title = "aws_lambda_version Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_lambda_version"
identifier = "inspec/resources/aws/aws_lambda_version Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_version` InSpec audit resource to test properties of a single AWS Lambda function version.

The `AWS::Lambda::Version` resource creates a version from the current code and configuration of a function. Use versions to create a snapshot of your function code and configuration that doesn't change.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the Lambda layer version exists.

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  it { should exist }
end
```

## Parameters

`layer_name` _(required)_

: The name or Amazon Resource Name (ARN) of the Lambda layer.

`version_number` _(required)_

: The version number.

## Properties

`content.location`
: A link to the layer archive in Amazon S3 that is valid for 10 minutes.

`content.code_sha_256`
: The SHA-256 hash of the layer archive.

`content.code_size`
: The size of the layer archive in bytes.

`content.signing_profile_version_arn`
: The Amazon Resource Name (ARN) for a signing profile version.

`content.signing_job_arn`
: The Amazon Resource Name (ARN) of a signing job.

`layer_arn`
: The ARN of the layer.

`layer_version_arn`
: The ARN of the layer version.

`description`
: The description of the version.

`created_date`
: The date that the layer version was created, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD).

`version`
: The version number.

`compatible_runtimes`
: The layer's compatible runtimes.

`license_info`
: The layer's software license.

`compatible_architectures`
: A list of compatible instruction set architectures.

## Examples

**Ensure a layer ARN is available.**

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  its('layer_arn') { should eq 'LAYER_ARN' }
end
```

**Ensure a layer version ARN is available.**

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  its('layer_version_arn') { should eq 'LAYER_VERSION_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_lambda_version(layer_name: 'LAYER_NAME', version_number: 1) do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:GetLayerVersionResponse" %}}
