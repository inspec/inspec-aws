---
title: About the aws_config_delivery_channel Resource
platform: aws
---

# aws_config_delivery_channel

The AWS Config service can monitor and record changes to your AWS resource configurations. A Delivery Channel can record the changes
to an S3 Bucket, an SNS or both.

Use the `aws_config_delivery_channel` InSpec audit resource to examine how the AWS Config service delivers those change notifications.

One delivery channel is allowed per region per AWS account, and the delivery channel is required to use AWS Config.

## Syntax

    describe aws_config_delivery_channel('CHANNEL_NAME') do
      it { should exist }
    end

    describe aws_config_delivery_channel(channel_name: 'CHANNEL_NAME') do
      it { should exist }
    end

Since you may only have one Delivery Channel per region, and InSpec connections are per-region, you may also omit the `channel_name` to obtain the one Delivery Channel (if any) that exists:

        describe aws_config_delivery_channel do
          it { should exist }
        end

## Parameters

`channel_name` _(optional)_

This resource accepts a single parameter, the channel name.
This can be passed either as a string or as a `channel_name: 'value'` key-value entry in a hash.

See also the [AWS documentation on Delivery Channels](https://docs.aws.amazon.com/config/latest/developerguide/manage-delivery-channel.html).


## Properties

| Property | Description |
| ---  | --- |
| channel_name | The name of the delivery channel. By default, AWS Config assigns the name "default" when creating the delivery channel. |
| s3_bucket_name | The name of the Amazon S3 bucket to which AWS Config delivers configuration snapshots and configuration history files. |
| s3_key_prefix | The prefix for the specified Amazon S3 bucket. |
| sns_topic_arn | The Amazon Resource Name (ARN) of the Amazon SNS topic to which AWS Config sends notifications about configuration changes. |
| delivery_frequency_in_hours | Specifies how often the AWS Config sends configuration changes to the s3 bucket in the delivery channel. |

## Examples

### Test how frequently the channel writes configuration changes to the s3 bucket.

    describe aws_config_delivery_channel(channel_name: 'CHANNEL_NAME') do
      its('delivery_frequency_in_hours') { should be > 3 }
    end

### Ensure configuration change notifications are being delivered to the correct bucket and key.

    describe aws_config_delivery_channel(channel_name: 'CHANNEL_NAME') do
      its('s3_bucket_name') { should eq 'S3_BUCKET_NAME' }
      its('s3_key_prefix')  { should eq 'logs/' }
    end

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should` to test that the entity exists.

    describe aws_config_delivery_channel(channel_name: 'CHANNEL_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_config_delivery_channel(channel_name: 'CHANNEL_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ConfigService:Client:DescribeDeliveryChannelsResponse` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Config](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsconfig.html).
