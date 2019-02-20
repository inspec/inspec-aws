---
title: About the aws_launch_configuration Resource
---

# aws\_launch\_configuration

Use the `aws_launch_configuration` InSpec audit resource to test properties of a single AWS Launch Configuration. 

<br>

## Availability

### Installation

### Version


## Syntax

    # Ensure that a queue exists and has a visibility timeout of 300 seconds
    describe aws_launch_configuration('my-config') do
      it { should exist }
      its('key_name') { should be 'my-key-name' }
    end

    # You may also use hash syntax to pass the launch configuration name
    describe aws_launch_configuration(launch_configuration_name: 'my-config') do
      it { should exist }
    end

## Resource Parameters

### name

This resource expects a single parameter, the name that uniquely identifies the of a Launch Configuration.

See also the [AWS documentation on Launch Configurations](https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchConfiguration.html).

<br>

## Properties

### arn

An string indicating the ARN of the launch configuration
    
    describe aws_launch_configuration('my-config') do
      its('arn') { should eq 'arn:aws:autoscaling:us-east-1:0123456'}
    end

### image\_id

An string indicating the AMI of the launch configuration
    
    describe aws_launch_configuration('my-config') do
      its('image_id') { should eq 'ami-012345'}
    end

### instance\_type

A string indicating the instance type of the launch configuration
    
    describe aws_launch_configuration('my-config') do
      its('instance_type') { should eq 't2.micro'}
    end

### iam\_instance\_profile

A string indicating the IAM profile for the launch configuration

    describe aws_launch_configuration('my-config') do
      its('iam_instance_profile') { should eq 'iam-profile' }
    end

### key\_name

A string indicating the AWS key pair for the launch configuration

    describe aws_launch_configuration('my-config') do
      its('key_name') { should eq 'key-name' }
    end

### security\_groups

An array of strings of the security group IDs associated with the launch configuration

    describe aws_launch_configuration('my-config') do
      its('security_groups') { should include 'security-group'}
    end

### associate\_public\_ip\_address

A boolean indicating if the launch configuration is configured to set a public IP address

    describe aws_launch_configuration('my-config') do
      its('associate_public_ip_address') { should be true }
    end

### user\_data

A string containing the user data configured for the launch configuration

    describe aws_launch_configuration('my-config') do
      its('user_data') { should include 'user-data' }
    end

### ebs\_optimized

A boolean indicating if the launch configuration is optimized for Amazon EBS

    describe aws_launch_configuration('my-config') do
      its('ebs_optimized') { should be true }
    end

### instance\_monitoring

A string indicating if instance monitoring is set to `detailed` or `basic`

    describe aws_launch_configuration('my-config') do
      its('instance_monitoring') { should eq 'detailed' }
    end

    describe aws_launch_configuration('my-config') do
        its('instance_monitoring') { should eq 'basic' }
    end

### spot\_price

A floating point number indicating the spot price configured

    describe aws_launch_configuration('my-config') do
      its('spot_price') { should be 0.1 }
    end
    
<br>
    
    
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Indicates that the Launch Configuration name provided was found.  Use `should_not` to test for Launch Configurations that should not exist.

    # Expect good news
    describe aws_launch_configuration('existing-launch-configuration') do
      it { should exist }
    end

    # No bad news allowed
    describe aws_launch_configuration('non-existing-launch-configuration') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:Describe*` action with Effect set to Allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups and launch configurations](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).