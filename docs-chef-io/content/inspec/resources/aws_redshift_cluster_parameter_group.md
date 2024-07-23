+++
title = "aws_redshift_cluster_parameter_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_redshift_cluster_parameter_group"
identifier = "inspec/resources/aws/aws_redshift_cluster_parameter_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_redshift_cluster_parameter_group` InSpec audit resource to test properties of a single specific Redshift cluster parameter group.

A Redshift cluster parameter group is uniquely identified by the parameter group name.

For additional information, including details on parameters and properties, see the [AWS documentation on Redshift cluster parameter group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a parameter_group_name exists.

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  it { should exist }
end
```

## Parameters

`parameter_group_name` _(required)_

## Properties

`parameter_group_name`
: The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.

`parameter_group_family`
: The family of the parameter group.

`description`
: The description of the parameter group.

`tags`
: The tags of the parameter group.

## Examples

**Ensure a parameter group name is available.**

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  its('parameter_group_name') { should eq 'test' }
end
```

**Check the family name in the cluster parameter group.**

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
    its('parameter_group_family') { should eq 'family_name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  it { should_not exist }
end
```

### be_available

Check if the IP address is available.

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  it { should be_available }
end
```

Use `should_not` to test an IP address that should not exist.

```ruby
describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
  it { should_not be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Redshift:Client:ClusterParameterGroupsMessage" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
