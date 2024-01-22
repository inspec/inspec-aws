+++
title = "aws_ssm_parameter Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ssm_parameter"
identifier = "inspec/resources/aws/aws_ssm_parameter Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_parameter` InSpec audit resource to test properties of a ssm parameter.

For additional information, including details on parameters and properties, see the [AWS documentation on SSM Parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/integration-ps-secretsmanager.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 An `aws_ssm_parameter` resource block uses the parameter to select a ssm parameter.

```ruby
describe aws_ssm_parameter(name: 'ssm-parameter-name-1234') do
  it { should exist }
end
```


## Parameters

`name` _(required)_

: This resource accepts a single parameter, the SSM Parameter Name.
  This can be passed either as a string or as a `aws_ssm_parameter: 'value'` key-value entry in a hash.

`with_decryption` _(optional)_

: This decrypts the value associated with the ssm parameter. This must be passed as a string `with_decryption: "true"`.

## Properties

`arn`
: Provides the Amazon Resource Name (ARN) of the parameter.

`data_type`
: Provides the data type of the parameter.

`last_modified_date`
: Provides the date the parameter was last changed or updated and the parameter version was created.

`name`
: Provides the name of the parameter.

`selector`
: Provides the version number or label used to retrieve the parameter value.

`source_result`
: Applies to parameters that reference information in other AWS services.

`type`
: Provides the type of the parameter.

`value`
: Provides the value of the parameter.

`version`
: Provides the version of the parameter.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Parameter.html)

## Examples

**Check the Name of a SSM Parameter.**

```ruby
describe aws_ssm_parameter(name: 'ssm_parameter-name-1234') do
  its('name')  { should eq 'ssm_parameter-name-1234' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_parameter(name: 'ssm_parameter-name-1234') do
  it { should exist }
end
```

```ruby
describe aws_ssm_parameter(name: 'ssm_parameter-name-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:GetParameterResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).