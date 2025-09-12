+++
title = "aws_ses_receipt_rule_set resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ses_receipt_rule_set"
identifier = "inspec/resources/aws/aws_ses_receipt_rule_set resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ses_receipt_rule_set` InSpec audit resource to test properties of a single AWS Simple Email Service (SES) receipt rule set.

The `AWS::SES::ReceiptRuleSet` resource specifies a receipt rule set.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SES ReceiptRuleSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptruleset.html).

## Syntax

Ensure that the rule set exists.

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
  it { should exist }
end
```

## Parameters

`rule_set_name` _(required)_

: The name of the receipt rule set to describe.

## Properties

`name`
: The name of the receipt rule.

`enabled`
: If `true`, the receipt rule is active. The default value is `false`.

`tls_policy`
: Specifies whether Amazon SES should require that incoming email is delivered over a connection encrypted with Transport Layer Security (TLS).

`recipients`
: The recipient domains and email addresses that the receipt rule applies to.

`actions`
: An ordered list of actions to perform on messages that match at least one of the recipient email addresses or domains specified in the receipt rule.

`s3_action_topic_arns`
: The ARN of the Amazon SNS topic to notify when the message is saved to the Amazon S3 bucket.

`s3_action_bucket_names`
: The name of the Amazon S3 bucket that incoming email will be saved to.

`s3_action_object_key_prefixes`
: The key prefix of the Amazon S3 bucket.

`s3_action_kms_key_arns`
: The customer master key that Amazon SES should use to encrypt your emails before saving them to the Amazon S3 bucket.

`bounce_action_topic_arns`
: The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the bounce action is taken.

`bounce_action_smtp_reply_codes`
: The SMTP reply code, as defined by RFC 5321.

`bounce_action_status_codes`
: The SMTP enhanced status code, as defined by RFC 3463.

`bounce_action_messages`
: Human-readable text to include in the bounce message.

`bounce_action_senders`
: The email address of the sender of the bounced email.

`workmail_action_topic_arns`
: The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the WorkMail action is called.

`workmail_action_organization_arns`
: The ARN of the Amazon WorkMail organization.

`lambda_action_topic_arns`
: The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the Lambda action is taken.

`lambda_action_function_arns`
: The Amazon Resource Name (ARN) of the AWS Lambda function.

`lambda_action_invocation_types`
: The invocation type of the AWS Lambda function.

`stop_action_scopes`
: The scope of the StopAction. The only acceptable value is RuleSet.

`stop_action_topic_arns`
: The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the stop action is taken.

`add_header_action_header_names`
: The name of the header to add. Must be between 1 and 50 characters, inclusive, and consist of alphanumeric (a-z, A-Z, 0-9) characters and dashes only.

`add_header_action_header_values`
: Must be less than 2048 characters, and must not contain newline characters ("r" or "n").

`sns_action_topic_arns`
: The Amazon Resource Name (ARN) of the Amazon SNS topic to notify.

`sns_action_encodings`
: The encoding to use for the email within the Amazon SNS notification.

`scan_enabled`
: If `true`, then messages that this receipt rule applies to are scanned for spam and viruses. The default value is `false`.

## Examples

**Ensure a rule set is available.**

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
  its('name') { should eq 'RULE_NAME' }
end
```

**Ensure that `scan_enabled` is `true` so that messages that this receipt rule is applied to are scanned for spam and viruses.**

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
    its('scan_enabled') { should eq true }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ses_receipt_rule_set(rule_set_name: 'RULE_SET_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SES:Client:DescribeReceiptRuleSetResponse" %}}
