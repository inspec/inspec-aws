---
title: About the aws_sns_topics Resource
---

# aws\_sns\_topics
Use the `aws_sns_topics` InSpec audit resource to test all or a group of the SNS Topic ARNs in an account.

User the 'aws_sns_topic' InSpec audit resource to test a single SNS Topic in an account.

<br>

## Syntax

An `aws_sns_topics` resource block takes no filter conditions.

    # Get all SNS Topic arns
    describe aws_sns_topics do
      its('topic_arns') { should include 'arn:aws:sns:us-east-1:333344445555:MyTopic' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_sns_topics`, its limited functionality precludes examples.

<br>

## Matchers

### exists

The control will pass if the filter returns at least one result. Use should_not if you expect zero matches.

    # Test if there is any SNS Topics
    describe aws_sns_topics
      it { should exist }
    end


## Properties

### topic\_arns

Provides an array of all SNS Topic arns.

    # Test that a specific SNS Topic exists
    describe aws_sns_topics do
      its('topic_arns') { should include 'arn:aws:sns:us-east-1:333344445555:MyTopic' }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `sns:ListTopics` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
