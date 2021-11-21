---
title: About the aws_redshift_cluster_parameter_groups Resource
platform: aws
---

# aws_redshift_cluster_parameter_groups

Use the `aws_redshift_cluster_parameter_groups` InSpec audit resource to test properties of some or all AWS Redshift cluster parameter groups.

## Syntax

Verify that a Parameter group name exists.

    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

See the [AWS documentation on Redshift cluster parameter group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html) for additional information.

### Properties

| Property                 | Description                                                                                                                                                        | Fields                   |
| ---                      | ---                                                                                                                                                                | ---                      |
| parameter_group_names    | The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned.   | parameter_group_name     |
| parameter_group_families | The family of the parameter group.                                                                                                                                 | parameter_group_family   |
| descriptions             | The description of the parameter group.                                                                                                                            | description              |
| tags                     | The tags of the parameter group.                                                                                                                                   | tags                    |

## Examples

### Ensure a Redshift cluster parameter group has parameter groups

    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end

### Verify the number of Redshift cluster parameter groups

    describe aws_redshift_cluster_parameter_groups do
        its('count') { should eq 5 }
    end

### Verify the family name exists for at least one of the cluster parameter groups

    describe aws_redshift_cluster_parameter_groups do
       its('parameter_group_families') { should include "FAMILY_NAME" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_redshift_cluster_parameter_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Redshift:Client:ClusterParameterGroupsMessage` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
