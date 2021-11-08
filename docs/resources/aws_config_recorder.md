---
title: About the aws_config_recorders Resource
platform: aws
---

# aws\_config\_recorders

Use the `aws_config_recorders` InSpec audit resource to test properties of collection of AWS Config Service.

The AWS Config service can monitor and record changes to your AWS resource configurations.  The Aws Config Recorder is used to detect changes in resource configurations and capture these changes as configuration items.

As of April 2018, you are only permitted one configuration recorder per region.

## Syntax

    describe aws_config_recorders do
      its('RECORDER_NAME) { should include 'GIVEN_RECORDER_NAME' }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on Configuration](https://docs.aws.amazon.com/config/latest/developerguide/aws-config-landing-page.html).


## Properties

|Property        | Description|
| ---            | --- |
|recorder\_name  | The name of the recorder. By default, AWS Config automatically assigns the name "default" when creating the configuration recorder. You cannot change the assigned name.  |
|role\_arn       | Amazon Resource Name (ARN) of the IAM role used to describe the AWS resources associated with the account.  |
|resource\_types | A comma-separated list that specifies the types of AWS resources for which AWS Config records configuration changes (i.e. AWS::EC2::Instance)  |
|last\_status    | The last (previous) status of the recorder.  |

## Examples

##### Test if the recorder is active and recording
    describe aws_config_recorder do
      it { should be_recording }
    end

##### Ensure the role\_arn is correct for the recorder
The role is used to grant permissions to S3 Buckets, SNS topics and to get configuration details for supported AWS resources.
    describe aws_config_recorder do
      its('role_arn') { should eq 'arn:aws:iam::721741954427:role/My_Recorder' }
    end

##### Test the recorder is monitoring changes to the correct resources.
    describe aws_config_recorder do
      its('resource_types') { should include 'AWS::EC2::CustomerGateway' }
      its('resource_types') { should include 'AWS::EC2::EIP' }
    end

##### Test recorder's last status
    describe aws_config_recorder do
      its('last_status') { should eq 'SUCCESS' }
    end

## Matchers

#### be\_recording
Ensure the recorder is active

      it { should be_recording }

#### be\_recording\_all\_resource\_types
Indicates if the ConfigurationRecorder will record changes for all resources, regardless of type. If this is true, resource\_types is ignored.

      it { should be_recording_all_resource_types }

#### be\_recording\_all\_global\_types
Indicates whether the ConfigurationRecorder will record changes for global resource types (such as [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)s).

      it { should be_recording_all_global_types }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ConfigService:Client:DescribeConfigurationRecordersResponse` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Config](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsconfig.html).
