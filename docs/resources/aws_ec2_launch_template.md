---
title: About the aws_ec2_launch_template Resource
platform: aws
---

# aws_ec2_launch_template

Use the `aws_ec2_launch_template` InSpec audit resource to test properties of a single AWS Launch Template.

The `AWS::EC2::LaunchTemplate` specifies a launch template for an Amazon EC2 instance. A launch template contains the parameters to launch an instance.

## Syntax

An `aws_ec2_launch_template` resource block declares the tests for a single  AWS Launch Template by either `launch_template_name` or `launch_template_id`.

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      it { should exist }
    end

    describe aws_ec2_launch_template(launch_template_name: 'LAUNCH_TEMPLATE_NAME') do
      it { should exist }
    end

## Parameters

This resource accepts a single parameter, either the `launch_template_id` or `launch_template_name`. At least one must be provided.

`launch_template_id` _(required)_

The ID of the EC2 launch_template. This is in the format of `lt-` followed by 8 or 17 hexadecimal characters.
This can be passed either as a string or as an `launch_template_id: 'value'` key-value entry in a hash.

For additional information, see the [AWS documentation on AWS EC2 LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html).

`launch_template_name` _(required if `launch_template_id` not provided)_

The name of launch template.

## Properties

| Property | Description |
| :---: | :--- |
| launch_template_name | The name of launch template. |
| launch_template_id | The id of the launch template. |
| create_time | The create time of the launch resource. |
| created_by | The time the instance was launched. |
| default_version_number | The availability zone of the instance. |
| latest_version_number | A hash containing the security group ids and names associated with the instance. |
| tags | A list of hashes with each key-value pair corresponding to an EC2 instance tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`. |
  
There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that an launch template should exist

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      it { should exist }
    end

##### Test that an EC2 instance is using the correct AMI

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      its('default_version_number') { should eq 1 }
    end

##### Test that an EC2 instance has the correct tag

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      its('launch_template_name') { should eq 'LAUNCH_TEMPLATE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_launch_template(launch_template_id: 'LAUNCH_TEMPLATE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeLaunchTemplatesResult` action with `Effect` set to `Allow`.


