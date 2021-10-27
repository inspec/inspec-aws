---
title: About the aws_shield_subscription Resource
platform: aws
---

# aws\_shield\_subscription

Use the `aws_shield_subscription` InSpec audit resource to test properties of an AWS Shield Advanced subscription.

## Syntax

An `aws_shield_subscription` resource block returns a Shield Advanced subscription.

    describe aws_shield_subscription do
      it { should exist }
    end


#### Parameters

This resource does not expect any parameters.

Also, see the [AWS Shield Subscriptions documentation](https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html).


## Properties

|Property                      | Description|
| ---                          | --- |
|auto\_renew                   | If `ENABLED`, the subscription will be automatically renewed at the end of the existing subscription period. Valid values: `ENABLED` or `DISABLED`. |
|end\_time                     | The date and time your subscription will end. |
|limits                        | Specifies how many protections of a given type you can create. This is an array containing the Type of protection and the maximum number of protections that can be created for the specified Type. |
|proactive\_engagement\_status | Valid values: `ENABLED`, `DISABLED`, `PENDING`. <br> If ENABLED, the DDoS Response Team (DRT) will use email and phone to notify contacts about escalations to the DRT and to initiate proactive customer support. <br/> If `PENDING`, you have requested proactive engagement and the request is pending. The status changes to `ENABLED` when your request is fully processed. <br/> If `DISABLED`, the DRT will not proactively notify contacts about escalations or to initiate proactive customer support. |
|start\_time                   | The start time of the subscription, in Unix time in seconds. |
|time\_commitment\_in\_seconds | The length, in seconds, of the AWS Shield Advanced subscription for the account. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/waf/latest/DDOSAPIReference/API_Subscription.html)

## Examples

### Check the automatic renewal status of a Shield Subscription

    describe aws_shield_subscription do
      its('auto_renew')  { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Shield:Client:DescribeSubscriptionResponse` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Shield](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awsshield.html).
