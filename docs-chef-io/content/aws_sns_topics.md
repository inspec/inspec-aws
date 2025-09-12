+++
title = "aws_sns_topics resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sns_topics"
identifier = "inspec/resources/aws/aws_sns_topics resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sns_topics` InSpec audit resource to test all or a group of the SNS Topic ARNs in an account.

User the 'aws_sns_topic' InSpec audit resource to test a single SNS Topic in an account.

For additional information, including details on parameters and properties, see the [AWS documentation on SNS](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html).

## Syntax

    # Get all SNS Topic arns

```ruby
describe aws_sns_topics do
  its('topic_arns') { should include 'arn:aws:sns:us-east-1:333344445555:MyTopic' }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`topic_arns`
: The ARNs of the SNS Topics.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

The following examples show how to use this InSpec audit resource.

Ensure a Topic exists:

```ruby
describe aws_sns_topics do
  its('topic_arns') { should include 'arn:aws:sns:us-east-1:333344445555:MyTopic' }
end
```

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_sns_topics do
  it { should exist }
end
```

```ruby
describe aws_sns_topics do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SNS:Client:ListTopicsResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
