---
title: About the aws_ses_receipt_rule_sets Resource
platform: aws
---

# aws_ses_receipt_rule_sets

Use the `aws_ses_receipt_rule_sets` InSpec audit resource to test properties of multiple AWS Simple Email Service (SES) receipt rule sets.

The `AWS::SES::ReceiptRuleSet` resource specifies a receipt rule set.

## Syntax

Ensure that the rule set exists.

    describe aws_ses_receipt_rule_sets do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS SES ReceiptRuleSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptruleset.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| names | The name of the receipt rule set. | name |
| created_timestamps | The date and time the receipt rule set was created. | created_timestamp |

## Examples

### Ensure a rule set name is available.

    describe aws_ses_receipt_rule_sets do
      its('names') { should include 'RULE_SET_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ses_receipt_rule_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ses_receipt_rule_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SES:Client:ListReceiptRuleSetsResponse` action with `Effect` set to `Allow`.
