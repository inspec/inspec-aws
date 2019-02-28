---
title: About the aws_auto_scaling_group Resource
platform: aws
---

# aws\_auto\_scaling\_group

Use the `aws_auto_scaling_group` InSpec audit resource to test properties of a single AWS Auto Scaling group. 

## Syntax

Ensure that an auto scaling group exists and has the correct scale sizes

    describe aws_auto_scaling_group('MyAutoScalingGroup') do
      it              { should exist }
      its('min_size') { should be 1}
      its('max_size') { should be 4}
    end  

You may also use hash syntax to pass the auto scaling group name
    
    describe aws_auto_scaling_group(name: 'MyAutoScalingGroup') do
      it { should exist }
    end

#### Parameters
##### Name

This resource expects a single parameter, the Auto Scaling Group Name which uniquely identifies the auto scaling group. 
This can be passed either as a string or as a `name: 'value'` hash.

See also the [AWS documentation on Auto Scaling Group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).

## Examples


Ensure that an auto scaling group has the correct desired capacity
   
    describe aws_auto_scaling_group('MyAutoScalingGroup') do
      it                      { should exist }
      its('desired_capacity') { should be 2 }
    end  
    
Ensure that an auto scaling group has the correct Launch Configuration name and VPC identifier

    describe aws_auto_scaling_group('MyAutoScalingGroup') do
      it                               { should exist }
      its('launch_configuration_name') { should eq 'MyLaunchConfiguration'}
      its('vpc_zone_identifier')       { should include 'subnet-1234'}
    end  
   
## Properties

|Property                    | Description|
| ---                        | --- |
|min\_size                   | An integer indicating the minimum number of instances in the auto scaling group |
|maximum\_size               | An integer indicating the maximum number of instances in the auto scaling group |
|desired\_capacity           | An integer indicating the desired  number of instances in the auto scaling group |
|launch\_configuration\_name | The name of the auto scaling launch configuration associated with the auto scaling group |
|vpc\_zone\_identifier       | An array of strings corresponding to the subnet IDs associated with the auto scaling group |
|tags                        | An array of objects with each object corresponding to a tag associated with the auto scaling group |

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Indicates that the auto scaling group name provided was found.  
Use `should_not` to test the entity should not exist.

    describe aws_auto_scaling_group('AnExistingASG') do
      it { should exist }
    end

    describe aws_auto_scaling_group('ANonExistentASG') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:Describe*` actions with Effect set to Allow.  
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).

