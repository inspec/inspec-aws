---
title: About the aws_vpc_endpoint_connection_notification Resource
platform: AWS
---

# AWS\_vpc\_endpoint\_connection\_notification

Use the `aws_vpc_endpoint_connection_notification` Inspec audit resource to test the properties of a single specific AWS VPC endpoint connection notification.

## Syntax

Ensure that an AWS VPC endpoint connection notification exists.

    # Find a AWS VPC endpoint connection notification by ID
    describe aws_vpc_endpoint_connection_notification('VPCE-NFN-12345678987654321') do
      it { should exist }
    end

    # Hash syntax for ID
    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'VPCE-NFN-12345678987654321') do
      it { should exist }
    end

### Parameters

`connection_notification_id` _(required)_

This resource expects the AWS VPC endpoint connection notification ID as a parameter.
This can be passed either as a string or as a `connection_notification_id: 'VALUE'` key-value entry in a hash.

See also the [AWS VPC endpoint connection notification documentation](https://docs.AWS.amazon.com/AWSCloudFormation/latest/UserGuide/AWS-resource-ec2-vpcendpointconnectionnotification.html).

## Properties

|Property                                   | Description|
| ---                                       | --- |
|vpc_endpoint_id                            | The ID of the endpoint. |
|connection_notification_id                 | The ID of the AWS VPC endpoint connection notification. |
|service_id                                 | The ID of the endpoint service. |
|connection_notification_type               | The type of notification.|
|connection_notification_arn                | The ARN of the SNS topic for the notifications. |
|connection_events                          | The endpoint events to receive a notification about. Valid values: `Accept`, `Connect`, `Delete`, and `Reject`.  |
|connection_notification_state              | The state of the AWS VPC endpoint connection notification. Valid values: `Enabled`, `Disabled`. |

## Examples

### Ensure an AWS VPC endpoint connection notification's ARN is available

    describe aws_vpc_endpoint_connection_notification(connection_notification_id: 'VPCE-NFN-12345678987654321') do
      its('CONNECTION_NOTIFICATION_ARN') { should eq 'ARN:AWS:SNS:US-EAST-2:112758395563:AWS-SNS-TOPIC-ENCRYPTION-BLOIXLVRSNFYBLZXNBGCBVHJU' }
    end

### Ensure that the VPC endpoint connection notification has a type using a key-value hash

    describe aws_vpc_endpoint_connection_notification(connection_notification_id: 'VPCE-NFN-12345678987654321') do
      its('connection_notification_type') { should eq 'TOPIC' }
    end

### Verify the ARN of a VPC endpoint connection notification.

    describe aws_vpc_endpoint_connection_notification('VPCE-NFN-12345678987654321') do
      its('CONNECTION_NOTIFICATION_ARN') { should eq 'ARN:AWS:SNS:US-EAST-2:112758395563:AWS-SNS-TOPIC-ENCRYPTION-BLOIXLVRSNFYBLZXNBGCBVHJU' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For the complete list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` returns at least one result.

### exist

Use `should_not` to test the entity should not exist.

    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'VPCE-NFN-12345678987654321') do
      it { should exist }
    end

Use `should` to test the entity should not exists.

    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'VPCE-NFN-12345678987654321') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), will need the `EC2:Client:DescribeVpcEndpointConnectionNotificationsResult` action with `Effect` set to `Allow`.

You can find the detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.AWS.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).