---
title: About the aws_config_delivery_channel Resource
---

# aws_config_delivery_channel

The AWS Config service can monitor and record changes to your AWS resource configurations. A Delivery Channel can record the changes
to an S3 Bucket, an SNS or both.

Use the `aws_config_delivery_channel` InSpec audit resource to examine how the AWS Config service delivers those change notifications.

One delivery channel is allowed per region per AWS account, and the delivery channel is required to use AWS Config.  For more details, see [the documentation](https://docs.aws.amazon.com/config/latest/developerguide/manage-delivery-channel.html).

<br>


## Resource Parameters

An `aws_config_delivery_channel` resource block declares the tests for a single AWS Config Delivery Channel.

You may specify the Delivery Channel name:

    describe aws_config_delivery_channel('my_channel') do
      it { should exist }
    end

    describe aws_config_delivery_channel(channel_name: 'my-channel') do
      it { should exist }
    end

However, since you may only have one Delivery Channel per region, and InSpec connections are per-region, you may also omit the `channel_name` to obtain the one Delivery Channel (if any) that exists:

    describe aws_config_delivery_channel do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test how frequently the channel writes configuration changes to the s3 bucket.

    describe aws_config_delivery_channel(channel_name: 'my-recorder') do
      its(delivery_frequency_in_hours) { should be > 3 }
    end

## Properties

### channel\_name

Returns the name of the Delivery Channel.

    describe aws_config_delivery_channel do
      its('channel_name') { should cmp 'my-channel' }
    end

### delivery\_frequency\_in\_hours

Provides how often the AWS Config sends configuration changes to the s3 bucket in the delivery channel.

    describe aws_config_delivery_channel(channel_name: 'my_channel')
      its('delivery_frequency_in_hours') { should eq 24 }
      its('delivery_frequency_in_hours') { should be > 24 }
    end

### s3\_bucket\_name

Provides the name of the s3 bucket that the channel sends configuration changes to. This is an optional value since a Delivery Channel can also talk to an SNS.

    describe aws_config_delivery_channel(channel_name: 'my_channel')
      its('s3_bucket_name') { should eq 'my_bucket' }
    end

### s3\_key\_prefix

Provides the s3 object key prefix (or "path") under which configuration data will be recorded.

    describe aws_config_delivery_channel(channel_name: 'my_channel')
      its('s3_key_prefix') { should eq 'log/' }
    end

### sns\_topic\_arn

Provides the ARN of the SNS topic for which the channel sends notifications about configuration changes.

    describe aws_config_delivery_channel(channel_name: 'my_channel')
      its('sns_topic_arn') { should eq 'arn:aws:sns:us-east-1:721741954427:sns_topic' }
    end

<br>

## Matchers

This resource provides no matchers, aside from the standard `exist` matcher.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `config:DescribeDeliveryChannels` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Config](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsconfig.html).
