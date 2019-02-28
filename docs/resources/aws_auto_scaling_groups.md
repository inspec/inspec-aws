---
title: About the aws_auto_scaling_groups Resource
platform: aws
---

# aws\_auto\_scaling\_groups

Use the `aws_auto_scaling_groups` InSpec audit resource to test the properties of a collection of AWS Auto Scaling Groups.

## Syntax

An `aws_auto_scaling_groups` resource block returns all Auto Scaling Groups and allows the testing of those ASGs.

    describe aws_auto_scaling_groups do
      its('names') { should include 'group-name' }
    end

## Examples

Ensure there are no groups with incorrect vpc_zone_identifiers.

      describe aws_auto_scaling_groups do
        it                          { should exist }
        its('vpc_zone_identifiers') { should_not include 'UNDESIRED-ZONE'}
      end

## Properties

|Property                     | Description|
| ---                         | --- |
|min\_sizes                   | An integer indicating the minimum number of instances in the auto scaling group |
|max\_sizes                   | An integer indicating the maximum number of instances in the auto scaling group |
|desired\_capacities          | An integer indicating the desired  number of instances in the auto scaling group |
|launch\_configuration\_names | The name of the auto scaling launch configuration associated with the auto scaling group |
|vpc\_zone\_identifiers       | An array of strings corresponding to the subnet IDs associated with the auto scaling group |
|health\_check\_types         | The service to use for the health checks. The valid values are EC2 and ELB. |
|tags                         | An array of objects with each object corresponding to a tag associated with the auto scaling group |

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Check that at least one entity was returned from the API.
Use `should_not` to test the entity should not exist.

    describe aws_auto_scaling_groups.where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_auto_scaling_groups.where( <property>: <value>) do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:Describe*` actions with Effect set to Allow.  
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).