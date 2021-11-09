---
title: About the aws_ses_receipt_rule Resource
platform: aws
---

# aws_ses_receipt_rule

Use the `aws_ses_receipt_rule` InSpec audit resource to test properties of the singular resource of AWS SES ReceiptRule.

The AWS::SES::ReceiptRule resource specifies a receipt rule.

## Syntax

Ensure that the rule exists.

    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
      it { should exist }
    end

## Parameters

`rule_set_name` _(required)_

The name of the receipt rule set that the receipt rule belongs to.

`rule_name` _(required)_

The name of the receipt rule.

For additional information, see the [AWS documentation on AWS SES ReceiptRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptrule.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| name | The name of the receipt rule. | name |
| enabled | If true , the receipt rule is active. The default value is false. | enabled |
| tls_policy | Specifies whether Amazon SES should require that incoming email is delivered over a connection encrypted with Transport Layer Security (TLS). | tls_policy |
| recipients | The recipient domains and email addresses that the receipt rule applies to. | recipients |
| actions | An ordered list of actions to perform on messages that match at least one of the recipient email addresses or domains specified in the receipt rule. | actions |
| s3_action_topic_arns | The ARN of the Amazon SNS topic to notify when the message is saved to the Amazon S3 bucket. | s3_action.topic_arn |
| s3_action_bucket_names | The name of the Amazon S3 bucket that incoming email will be saved to. | s3_action.bucket_name |
| s3_action_object_key_prefixes | The key prefix of the Amazon S3 bucket. | s3_action.object_key_prefix |
| s3_action_kms_key_arns | The customer master key that Amazon SES should use to encrypt your emails before saving them to the Amazon S3 bucket. | s3_action.kms_key_arn |
| bounce_action_topic_arns | The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the bounce action is taken. | bounce_action.topic_arn |
| bounce_action_smtp_reply_codes | The SMTP reply code, as defined by RFC 5321. | bounce_action.smtp_reply_code |
| bounce_action_status_codes | The SMTP enhanced status code, as defined by RFC 3463. | bounce_action.status_code |
| bounce_action_messages | Human-readable text to include in the bounce message. | bounce_action.message |
| bounce_action_senders | The email address of the sender of the bounced email. | bounce_action.sender |
| workmail_action_topic_arns | The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the WorkMail action is called. | workmail_action.topic_arn |
| workmail_action_organization_arns | The ARN of the Amazon WorkMail organization. | workmail_action.organization_arn |
| lambda_action_topic_arns | The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the Lambda action is taken. | lambda_action.topic_arn |
| lambda_action_function_arns | The Amazon Resource Name (ARN) of the AWS Lambda function. | lambda_action.function_arn |
| lambda_action_invocation_types | The invocation type of the AWS Lambda function. | lambda_action.invocation_type |
| stop_action_scopes | The scope of the StopAction. The only acceptable value is RuleSet. | stop_action.scope |
| stop_action_topic_arns | The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the stop action is taken. | stop_action.topic_arn |
| add_header_action_header_names | The name of the header to add. Must be between 1 and 50 characters, inclusive, and consist of alphanumeric (a-z, A-Z, 0-9) characters and dashes only. | add_header_action.header_name |
| add_header_action_header_values | Must be less than 2048 characters, and must not contain newline characters ("r" or "n"). | add_header_action.header_value |
| sns_action_topic_arns | The Amazon Resource Name (ARN) of the Amazon SNS topic to notify. | sns_action.topic_arn |
| sns_action_encodings | The encoding to use for the email within the Amazon SNS notification. | sns_action.encoding |
| scan_enabled | If true , then messages that this receipt rule applies to are scanned for spam and viruses. The default value is false. | scan_enabled |

## Examples

### Ensure a rule is available.
    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
      its('name') { should eq 'RULE_NAME' }
    end

### Ensure that the scan enabled is `true`.
    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
        its('scan_enabled') { should eq true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ses_receipt_rule(rule_set_name: 'RULE_SET_NAME', rule_name: 'RULE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SES:Client:DescribeReceiptRuleResponse` action with `Effect` set to `Allow`.