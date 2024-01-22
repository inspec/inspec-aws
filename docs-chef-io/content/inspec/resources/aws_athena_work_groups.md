+++
title = "aws_athena_work_groups Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_athena_work_groups"
identifier = "inspec/resources/aws/aws_athena_work_groups Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_athena_work_groups` InSpec audit resource to test properties of multiple Amazon Athena workgroups.

For additional information, including details on parameters and properties, see the [AWS Athena workgroup documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

```ruby
describe aws_athena_work_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The workgroup name.

`states`
: The state of the workgroup. Valid values are: `ENABLED` or `DISABLED`.

`descriptions`
: The workgroup description.

`creation_times`
: The workgroup creation time. Format: YYYY-MM-DD HH:MM:SS ZZZZ.

## Examples

**Ensure a work_group name is available.**

```ruby
describe aws_athena_work_groups do
  its('names') { should include 'WORK_GROUP_NAME' }
end
```

**Ensure that the state is `ENABLED` or `DISABLED`.**

```ruby
describe aws_athena_work_groups do
    its('states') { should include 'ENABLED' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_athena_work_groups do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_athena_work_groups do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_athena_work_groups do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Athena:Client:ListWorkGroupsOutput" %}}
