---
title: About the aws_vpc_endpoint_connection_notification Resource
platform: aws
---

# aws\_vpc\_endpoint\_connection\_notification

Use the `aws_vpc_endpoint_connection_notification` InSpec audit resource to test properties of a single specific Aws VPC Endpoint Connection Notification.

A Aws VPC Endpoint Connection Notification is uniquely identified by the Aws VPC Endpoint Connection Notification ID (e.g vpce-123456abcdef12345)

## Syntax

Ensure that a Aws VPC Endpoint Connection Notification exists.

    # Find a Aws VPC Endpoint Connection Notification by ID
    describe aws_vpc_endpoint_connection_notification('vpce-nfn-12345678987654321') do
      it { should exist }
    end
    
    # Hash syntax for ID
    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'vpce-nfn-12345678987654321') do
      it { should exist }
    end


Confirm that ARN to a Aws VPC Endpoint Connection Notification is as expected.

    describe aws_vpc_endpoint_connection_notification('vpce-nfn-12345678987654321') do
      its('connection_notification_arn') { should eq 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
    end

Confirm that the type of a Aws VPC Endpoint Connection Notification is as expected.

    describe aws_vpc_endpoint_connection_notification('vpce-nfn-12345678987654321') do
      its('connection_notification_type') { should eq 'Topic' }
    end


## Parameters

This resource expects the Aws VPC Endpoint Connection Notification ID as a parameter.

See also the [AWS documentation on Aws VPC Endpoint Connection Notifications](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointconnectionnotification.html).

## Properties

|Property                                   | Description|
| ---                                       | --- |
|vpc_endpoint_id                            | The ID of the endpoint |
|connection_notification_id                 | The ID of the Aws VPC Endpoint Connection Notification |
|service_id                                 | The Service ID of the Aws VPC Endpoint Connection Notification. |
|connection_notification_type               | Type of the Aws VPC Endpoint Connection Notification.|
|connection_notification_arn                | The ARN of the Aws VPC Endpoint Connection Notification. |
|connection_events                          | The Events on which the notification is triggred. |
|connection_notification_state              | The state of the Aws VPC Endpoint Connection Notification. one of "Enabled", "Disabled. |

## Examples

##### Ensure a Aws VPC Endpoint Connection Notification's ARN is available.
    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'vpce-nfn-12345678987654321') do
      its('connection_notification_arn') { should eq 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
      
    end

##### Ensure that the VPC Endpoint Connection Notification has a type.
    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'vpce-nfn-12345678987654321') do
      its('connection_notification_type') { should eq 'Topic' }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the describe returns at least one result.

#### exist

Use `should_not` to test the entity should not exist.

    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'vpce-nfn-12345678987654321') do
      it { should exist }
    end
      
    describe aws_vpc_endpoint_connection_notification(connection-notification-id: 'vpce-nfn-12345678987654321') do
      it { should_not exist }
    end


## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:VpcEndpointConnectionNotifications` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
