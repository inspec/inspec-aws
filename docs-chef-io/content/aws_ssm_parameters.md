+++
title = "aws_ssm_parameters resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_parameters"
identifier = "inspec/resources/aws/aws_ssm_parameters resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_parameters` InSpec audit resource to test properties of a collection of AWS SSM parameters.

## Syntax

 Ensure you have exactly 3 SSM Parameters

```ruby
describe aws_ssm_parameters do
  its('names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: Provides the name of the parameter.

`types`
: Provides the type of the parameter.

`key_ids`
: Provides the key id of the parameter.

`last_modified_dates`
: Provides the date the parameter was last changed or updated and the parameter version was created.

`last_modified_users`
: Provides the user that last changed or updated the parameter.

`descriptions`
: Provides the description of the parameter.

`versions`
: Provides the version of the parameter.

`tiers`
: Provides the tier of the parameter.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Parameter.html)

## Examples

**Ensure Name of a SSM Parameter exists.**

```ruby
describe aws_ssm_parameters do
  its('names') { should include 'ssm-parameter-name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_parameters.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_ssm_parameters.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeParametersResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).
