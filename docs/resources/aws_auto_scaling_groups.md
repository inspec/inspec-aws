---
title: About the aws_auto_scaling_groups Resource
---

# aws\_auto\_scaling\_groups

Use the `aws_auto_scaling_groups` InSpec audit resource to test properties of some or all AWS Auto Scaling Groups.

<br>

## Syntax

An `aws_auto_scaling_groups` resource block returns all Auto Scaling Groups and allows the testing of those groups.

    describe aws_auto_scaling_groups do
      its('names') { should include 'group-name' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    Ensure there are no groups with incorrect vpc_zone_identifiers.

      describe aws_auto_scaling_groups do
        it                               { should exist }
        its('vpc_zone_identifiers')      { should_not include 'UNDESIRED-ZONE'}
      end
<br>

## Properties

* names 
* min_sizes 
* max_sizes 
* desired_capacities 
* vpc_zone_identifiers
* launch_configuration_names
* tags
* health_check_types

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

      describe aws_auto_scaling_groups.where( <property>: <value>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:Describe*` actions with Effect set to Allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).