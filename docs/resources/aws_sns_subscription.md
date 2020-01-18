---
title: About the aws_sns_subscription Resource
---

# aws\_sns\_subscription

Use the `aws_sns_subscription` InSpec audit resource to test detailed properties of a AWS SNS Subscription.


## Syntax

An `aws_sns_subscription` resource block uses resource parameters to search for a SNS Subscription, and then tests that subscriptions properties.  If no Subscriptions match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.

    describe aws_sns_subscription('arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6') do
      it { should exist }
    end

#### Parameters

##### subscription\_arn _(required)_

This resource accepts a single parameter, the subscription_arn. 
This can be passed either as a string or as a `subscription_arn: 'value'` key-value entry in a hash.

See also the [AWS documentation on SNS](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html).

## Properties

|Property                       | Description|
| ---                           | --- |
|arn                            | An integer indicating the minimum number of instances in the auto scaling group |
|owner                          | An integer indicating the maximum number of instances in the auto scaling group |
|raw\_message\_delivery           | An integer indicating the desired  number of instances in the auto scaling group |
|topic\_arn                      | The name of the auto scaling launch configuration associated with the auto scaling group |
|protocol                       | An array of strings corresponding to the subnet IDs associated with the auto scaling group |
|confirmation\_was\_authenticated | An hash with each key-value pair corresponding to a tag associated with the entity |

              
## Examples

##### Inspect the endpoint
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      # If protocol is 'sms', this should be a phone number:
      its('endpoint') { should cmp '+16105551234' }
      # If protocol is 'email' or 'email-json', endpoint should be an email address
      its('endpoint') { should cmp 'myemail@example.com' }
      # If protocal is 'http', endpoint should be a URL beginning with 'https://'
      its('endpoint') { should cmp 'https://www.exampleurl.com' }
      # If the protocol is 'lambda', its endpoint should be the ARN of a AWS Lambda function
      its('endpoint') { should cmp 'rn:aws:lambda:us-east-1:account-id:function:myfunction' }
    end

##### Inspect the owners ID
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      its('owner') { should cmp '12345678' }
    end

##### Inspect the endpoint
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      its('protocol') { should cmp 'sqs' }
    end

## Matchers

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

      it { should exist }

      it { should_not exist }

#### be\_confirmation\_authenticated

Provides whether or not the subscription confirmation request was authenticated.

    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::NOGOOD:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should be_confirmation_authenticated }
    end

#### have\_raw\_message\_delivery

Provides whether or not the original message is passed as is, not formatted as a json or yaml.

    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::NOGOOD:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should have_raw_message_delivery }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `sns:GetSubscriptionAttributes` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
