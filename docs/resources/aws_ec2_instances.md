---
title: About the aws_ec2_instances Resource
platform: aws
---

# aws\_ec2\_instances

Use the `aws_ec2_instances` InSpec audit resource to test properties of some or all AWS EC2 instances. To audit a single EC2 instance, use `aws_ec2_instance` (singular).

## Syntax

An `aws_ec2_instances` resource block collects a group of EC2 Instances and then tests that group.

    describe aws_ec2_instances
      it { should exist }
    end   
    
#### Parameters

This resource does not expect any parameters.

## Properties

|Property        | Description|
| ---            | --- |
|instance\_ids   | The ID of the EC2 instance. |
|vpc\_ids        | The VPC with which the EC2 instance is associated. |
|subnet\_ids     | The subnet with which the EC2 instance is associated. |
|instance\_types | The type of instance, for example m5.large. |
|entries         | Provides access to the raw results of the query, which can be treated as an array of hashes. |

## Examples

##### Ensure you have exactly 3 instances
    describe aws_ec2_instances do
      its('instance_ids.count') { should cmp 3 }
    end

##### Use this InSpec resource to request the IDs of all EC2 instances, then test in-depth using `aws_ec2_instance`.
    aws_ec2_instances.instance_ids.each do |instance_id|
      describe aws_ec2_instance(instance_id) do
        it              { should_not have_roles }
        its('key_name') { should cmp 'admin-ssh-key' }
        its('image_id') { should eq 'ami-27a58d5c' }
      end 
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ec2_instance.where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_ec2_instance.where( <property>: <value>) do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeInstances`, and `iam:GetInstanceProfile` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
