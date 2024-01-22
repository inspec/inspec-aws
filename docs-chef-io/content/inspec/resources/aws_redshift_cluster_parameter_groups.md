+++
title = "aws_redshift_cluster_parameter_groups Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_redshift_cluster_parameter_groups"
identifier = "inspec/resources/aws/aws_redshift_cluster_parameter_groups Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_redshift_cluster_parameter_groups` InSpec audit resource to test properties of some or all AWS Redshift cluster parameter groups.

This resource does not expect any parameters.

For additional information, including details on parameters and properties, see the [AWS documentation on Redshift cluster parameter group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Verify that a Parameter group name exists.

```ruby
describe aws_redshift_cluster_parameter_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`parameter_group_names`
: The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.

: **Field**: `parameter_group_name`

`parameter_group_families`
: The family of the parameter group.

: **Field**: `parameter_group_family`

`descriptions`
: The description of the parameter group.

: **Field**: `description`

`tags`
: The tags of the parameter group.

: **Field**: `tags`

## Examples

**Ensure a Redshift cluster parameter group has parameter groups.**

```ruby
describe aws_redshift_cluster_parameter_groups do
  it { should exist }
end
```

**Verify the number of Redshift cluster parameter groups.**

```ruby
describe aws_redshift_cluster_parameter_groups do
    its('count') { should eq 5 }
end
```

**Verify the family name exists for at least one of the cluster parameter groups.**

```ruby
describe aws_redshift_cluster_parameter_groups do
   its('parameter_group_families') { should include "FAMILY_NAME" }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_redshift_cluster_parameter_groups do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_redshift_cluster_parameter_groups do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Redshift:Client:ClusterParameterGroupsMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
