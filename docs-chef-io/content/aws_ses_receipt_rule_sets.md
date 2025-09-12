+++
title = "aws_ses_receipt_rule_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ses_receipt_rule_sets"
identifier = "inspec/resources/aws/aws_ses_receipt_rule_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ses_receipt_rule_sets` InSpec audit resource to test properties of multiple AWS Simple Email Service (SES) receipt rule sets.

The `AWS::SES::ReceiptRuleSet` resource specifies a receipt rule set.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SES ReceiptRuleSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptruleset.html).

## Syntax

Ensure that the rule set exists.

```ruby
describe aws_ses_receipt_rule_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The name of the receipt rule set.

: **Field**: `name`

`created_timestamps`
: The date and time the receipt rule set was created.

: **Field**: `created_timestamp`

## Examples

Ensure a rule set name is available:

```ruby
describe aws_ses_receipt_rule_sets do
  its('names') { should include 'RULE_SET_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ses_receipt_rule_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ses_receipt_rule_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SES:Client:ListReceiptRuleSetsResponse" %}}
