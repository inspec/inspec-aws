---
title: About the aws_ec2_launch_templates Resource
platform: aws
---

# aws_ec2_launch_templates

Use the `aws_ec2_launch_templates` InSpec audit resource to test properties of a all the AWS Launch templates.

## Syntax

An `aws_ec2_launch_templates` resource block declares the tests for a all the AWS Launch templates.

    describe aws_ec2_launch_templates do
        it { should exist }
    end

## Parameters

This resource does not require any required parameters.

## Properties

| Property | Description | Fields |
| --- | --- | --- |
|launch_template_name     | The name of launch template.|
|launch_template_id       | The id of the launch template. |
|create_time              | The create time of the launch template. |
|created_by               | The name by whom the launch template is created  |
|default_version_number   | The default_version_number of the launch template |
|latest_version_number    | The latest_version_number of the launch template |
|tags                     | A list of hashes with each key-value pair corresponding to an EC2 Launch template tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

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

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).
