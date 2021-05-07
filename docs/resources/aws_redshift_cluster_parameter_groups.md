---
title: About the aws_redshift_cluster_parameter_groups Resource
platform: aws
---

# aws\_redshift\_cluster\_parameter\_groups

Use the `aws_redshift_cluster_parameter_groups` InSpec audit resource to test properties of some or all AWS Redshift Cluster Parameter Group.

## Syntax

Verify that a Parameter group name exists.

    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end

An `aws_redshift_cluster_parameter_groups` resource block uses an optional filter to select a group of Redshift Cluster Parameter Groups and then test that group.

## Parameters

This resource does not expect any parameters.

See the [AWS documentation on Redshift Cluster Parameter Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html) for additional information.

## Properties

| Property | Description|
| --- | --- |
| parameter_group_names | The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned. |
| parameter_group_families | The family of the parameter group. |
| descriptions | The description of the parameter group. |
| tags | The tags of the parameter group. |

## Examples

##### Ensure a Redshift Cluster Parameter Group has parameter groups.
    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end

##### Match count of Redshift Cluster Parameter Group.
    describe aws_redshift_cluster_parameter_groups do
        its('count') { should eq 5 }
    end

##### Check family whether it is correct or not
    describe aws_redshift_cluster_parameter_groups do
       its('families') { should include "family_name" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.
      
    describe aws_redshift_cluster_parameter_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `redshift:describe_cluster_parameter_groups` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
