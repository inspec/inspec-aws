---
title: About the aws_vpc_endpoint_connection_notifications Resource
platform: AWS
---

# AWS\_vpc\_endpoint\_connection\_notifications

<<<<<<< HEAD
Use the `aws_vpc_endpoint_connection_notifications` InSpec audit resource to test the properties of a single specific AWS VPC Endpoint Connection Notification.

## Syntax

Ensure that an AWS VPC Endpoint Connection Notifications exists.
=======
Use the `aws_vpc_endpoint_connection_notifications` InSpec audit resource to test properties of a single specific AWS VPC Endpoint Connection Notification.



## Syntax

Ensure that a AWS VPC Endpoint Connection Notifications exists.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1

    describe aws_vpc_endpoint_connection_notifications do
      it { should exist }
    end
    
<<<<<<< HEAD
    # Hash syntax for ID
    describe aws_vpc_endpoint_connection_notifications do
      it { should exist }
    end

Confirm that ARN to an AWS VPC Endpoint Connection Notification is as expected.
=======
 
Confirm that ARN to a AWS VPC Endpoint Connection Notification is as expected.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1

    describe aws_vpc_endpoint_connection_notifications do
      its('connection_notification_arns') { should include 'arn:AWS:sns:us-east-2:112758395563:AWS-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
    end

<<<<<<< HEAD
Confirm that the type of an AWS VPC Endpoint Connection Notification is as expected.
=======
Confirm that the type of a AWS VPC Endpoint Connection Notification is as expected.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1

    describe aws_vpc_endpoint_connection_notifications do
      its('connection_notification_types') { should include 'Topic' }
    end

## Parameters

This resource expects the AWS VPC Endpoint Connection Notification ID as a parameter.

See also the [AWS documentation on AWS VPC Endpoint Connection Notifications](https://docs.AWS.amazon.com/AWSCloudFormation/latest/UserGuide/AWS-resource-ec2-vpcendpointconnectionnotification.html).

## Properties

|Property                                   | Description|
| ---                                       | --- |
|vpc_endpoint_id                            | The ID of the endpoint. |
|connection_notification_id                 | The ID of the AWS VPC Endpoint Connection Notification. |
|service_id                                 | The Service ID of the AWS VPC Endpoint Connection Notification. |
|connection_notification_type               | Type of the AWS VPC Endpoint Connection Notification.|
|connection_notification_arn                | The ARN of the AWS VPC Endpoint Connection Notification. |
<<<<<<< HEAD
|connection_events                          | The Events on which the notification is triggered. |
|connection_notification_state              | The state of the AWS VPC Endpoint Connection Notification. Possible values are "Enabled", "Disabled". |

## Examples

##### Ensure a Aws VPC Endpoint Connection Notification is as exist using vpc_endpoint_id

=======
|connection_events                          | The Events on which the notification is triggred. |
|connection_notification_state              | The state of the AWS VPC Endpoint Connection Notification. Possible values are Enabled, Disabled. |

## Examples

##### Ensure a AWS VPC Endpoint Connection Notification is as exist using vpc_endpoint_id.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1
    describe aws_vpc_endpoint_connection_notifications.where( vpc_endpoint_id: vpc-12345678 )
      it { should exist }
    end

<<<<<<< HEAD
##### Ensure a Aws VPC Endpoint Connection Notification is as exist

=======
##### Ensure a AWS VPC Endpoint Connection Notification is as exist.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1
    describe aws_vpc_endpoint_connection_notifications.where( connection_notification_id: 'vpce-nfn-03ad3532a5c71f8af' ) do
      it { should exist }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` returns at least one result.

#### exist

Use `should_not` to test the entity should not exist.

    describe aws_vpc_endpoint_connection_notifications(connection-notification-id: 'vpce-nfn-12345678987654321') do
      it { should exist }
    end

Use `should` to test the entity should not exists.

    describe aws_vpc_endpoint_connection_notifications(connection-notification-id: 'vpce-nfn-12345678987654321') do
      it { should_not exist }
    end

## AWS Permissions

<<<<<<< HEAD
To get the permission for the [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), you need the `ec2:VpcEndpointConnectionNotifications` action with effect set to `Allow`.
=======
Your [Principal](https://docs.AWS.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:VpcEndpointConnectionNotifications` action with Effect set to Allow.
>>>>>>> d8e6c62aeee3e8366f4034ae235b667f314f10d1

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.AWS.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
