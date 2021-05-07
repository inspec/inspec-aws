---
title: About the aws_redshift_cluster_parameter_group Resource
platform: aws
---

# aws\_redshift\_cluster\_parameter\_group

Use the `aws_redshift_cluster_parameter_group` InSpec audit resource to test properties of a single specific Redshift Cluster Parameter Group. 

A Redshift Cluster Parameter Group is uniquely identified by the parameter group name.

## Syntax

Ensure that a parameter_group_name exists.

    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      it { should exist }
    end

Ensure that a parameter_group_name not exists.

    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'dummy') do
      it { should exist }
    end

## Parameters

`parameter_group_name` _(required)_

For additional information, see the [AWS documentation on Redshift Cluster Parameter Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html).

## Properties

| Property | Description|
| --- | --- |
| parameter_group_name | The name of a specific parameter group for which to return details. By default, details about all parameter groups and the default parameter group are returned. |
| parameter_group_family | The family of the parameter group. |
| description | The description of the parameter group. |
| tags | The tags of the parameter group. |

## Examples

### Ensure a Parameter group name is available.
    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      its('parameter_group_name') { should eq 'test' }
    end

### Check the family name in the Cluster Parameter group.
    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
        its('family') { should eq 'family_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      it { should_not exist }
    end

### be_available

Check if the IP address is available.

    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      it { should be_available }
    end

Use `should_not` to test an IP address that should not exist.

    describe aws_redshift_cluster_parameter_group(parameter_group_name: 'test') do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `redshift:describe_cluster_parameter_groups` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.