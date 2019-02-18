---
title: About the aws_config_recorder Resource
---

# aws\_config\_recorder

Use the `aws_config_recorder` InSpec audit resource to test properties of your AWS Config Service.

The AWS Config service can monitor and record changes to your AWS resource configurations.  The Aws Config Recorder is used to detect changes in resource configurations and capture these changes as configuration items.

As of April 2018, you are only permitted one configuration recorder per region.

<br>

## Resource Parameters

An `aws_config_recorder` resource block declares the tests for a single AWS configuration recorder.

You may specify a recorder by name:

    describe aws_config_recorder('my_recorder') do
      it { should exist }
    end

    describe aws_config_recorder(recorder_name: 'my-recorder') do
      it { should exist }
    end

However, since you may only have one recorder per region, and InSpec connections are per-region, you may also omit the `recorder_name` to obtain the one recorder (if any) that exists:

    describe aws_config_recorder do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test if the recorder is active and recording.

    describe aws_config_recorder(recorder_name: 'my-recorder') do
      it { should be_recording }
    end

## Properties

### role\_arn

Provides the IAM role arn associated with the configuration recorder.  The role is used to grant permissions to S3 Buckets, SNS topics and to get configuration details for supported AWS resources.

    describe aws_config_recorder(username: 'bob')
      its('role_arn') { should eq 'arn:aws:iam::721741954427:role/My_Recorder' }
    end

### resource\_types

Provides a list of AWS resource types for which the AWS Config records configuration will change. Note that if be_recording_all_resource_types is true than this property is meaningless and will return and empty array.

    describe aws_config_recorder(username: 'bob')
      its('resource_types') { should include 'AWS::EC2::CustomerGateway' }
      its('resource_types') { should include 'AWS::EC2::EIP' }
    end

<br>

## Matchers

### be\_recording\_all\_resource\_types

Indicates if the ConfigurationRecorder will record changes for all resources, regardless of type. If this is true, resource_types is ignored.

      it { should be_recording_all_resource_types }

### be\_recording\_all\_global\_types

Indicates whether the ConfigurationRecorder will record changes for global resource types (such as [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)s).

      it { should be_recording_all_global_types }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `config:DescribeConfigurationRecorders` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Config](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsconfig.html).
