---
title: About the aws_ec2_launch_templates Resource
platform: aws
---

# aws_ec2_launch_templates

Use the `aws_ec2_launch_templates` InSpec audit resource to test properties of a all the AWS Launch templates.

The `AWS::EC2::LaunchTemplate` specifies a launch template for an Amazon EC2 instance. A launch template contains the parameters to launch an instance.

## Syntax

An `aws_ec2_launch_templates` resource block declares the tests for a all the AWS Launch templates.

    describe aws_ec2_launch_templates do
        it { should exist }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on AWS EC2 LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| launch_template_name | The name of launch template.|
| launch_template_id | The id of the launch template. |
| create_time | The create time of the launch template. |
| created_by | The name by whom the launch template is created.  |
| default_version_number | The default_version_number of the launch template. |
| latest_version_number | The latest_version_number of the launch template. |
| tags | A list of hashes with each key-value pair corresponding to an EC2 Launch template tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`. |

## Examples

### Test that an launch templates should exist

    describe aws_ec2_launch_templates do
        it { should exist }
    end

### Test that an EC2 instance is using the correct AMI

    describe aws_ec2_launch_templates do
        its('launch_template_ids.count') { should cmp 3 }
    end

### Test that an EC2 instance has the correct tag

    describe aws_ec2_launch_templates do
        its('launch_templates_names') { should include 'test-lt' }
    end

## Matchers

Use `should` to test that the entity exists.

    describe aws_ec2_launch_templates do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_launch_templates do
      it { should_not exist }
    end

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeLaunchTemplatesResult` action with `Effect` set to `Allow`.
