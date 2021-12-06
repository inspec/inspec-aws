---
title: About the aws_vpc_endpoint_connection_notifications Resource
platform: AWS
---

# AWS\_vpc\_endpoint\_connection\_notifications

Use the `aws_vpc_endpoint_connection_notifications` InSpec audit resource to test the properties of multiple AWS VPC endpoint connection notification.

## Syntax

Ensure that an AWS VPC endpoint connection notification exists.

    describe aws_vpc_endpoint_connection_notifications do
      it { should exist }
    end

See also the [AWS VPC endpoint connection notification documentation](https://docs.AWS.amazon.com/AWSCloudFormation/latest/UserGuide/AWS-resource-ec2-vpcendpointconnectionnotification.html).

## Parameters

This resource does not expect any parameters.

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

### Verify an AWS VPC endpoint connection notification exists using the VPC endpoint ID

    describe aws_vpc_endpoint_connection_notifications.where( vpc_endpoint_id: vpc-12345678 )
      it { should exist }
    end

### Ensure a AWS VPC endpoint connection notification exists

    describe aws_vpc_endpoint_connection_notifications.where( connection_notification_id: 'VPCE-NFN-03AD3532A5C71F8AF' ) do
      it { should exist }
    end

### Confirm that the AWS VPC endpoint connection notification ARN is as expected.

    describe aws_vpc_endpoint_connection_notifications do
      its('CONNECTION_NOTIFICATION_ARNS') { should include 'ARN:AWS:SNS:US-EAST-2:112758395563:AWS-SNS-TOPIC-ENCRYPTION-BLOIXLVRSNFYBLZXNBGCBVHJU' }
    end

### Confirm that the type of AWS VPC endpoint connection notification is as expected.

    describe aws_vpc_endpoint_connection_notifications do
      its('CONNECTION_NOTIFICATION_TYPES') { should include 'TOPIC' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` returns at least one result.

### exist

Use `should_not` to test the entity should not exist.

    describe aws_vpc_endpoint_connection_notifications(connection-notification-id: 'VPCE-NFN-12345678987654321') do
      it { should exist }
    end

Use `should` to test the entity should not exists.

    describe aws_vpc_endpoint_connection_notifications(connection-notification-id: 'VPCE-NFN-12345678987654321') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), will need the `EC2:Client:DescribeVpcEndpointConnectionNotificationsResult` action with `Effect` set to `Allow`.

You can find the detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.AWS.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
