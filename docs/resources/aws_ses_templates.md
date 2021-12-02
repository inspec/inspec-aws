---
title: About the aws_ses_templates Resource
platform: aws
---

# aws_ses_templates

Use the `aws_ses_templates` InSpec audit resource to test properties of multiple AWS Simple Email Service (SES) templates.

The `AWS::SES::Template` resource specifies an email template.

## Syntax

Ensure that the template exists.

    describe aws_ses_templates do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS SES Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| names | The name of the template. | name |
| created_timestamps | The time and date the template was created. | created_timestamp |

## Examples

### Ensure a template name is available.

    describe aws_ses_templates do
      its('names') { should include 'TEMPLATE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ses_templates do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ses_templates do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SES:Client:ListTemplatesResponse` action with `Effect` set to `Allow`.
