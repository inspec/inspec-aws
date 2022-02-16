---
title: About the aws_ses_template Resource
platform: aws
---

# aws_ses_template

Use the `aws_ses_template` InSpec audit resource to test properties of a single AWS Simple Email Service (SES) template.

The `AWS::SES::Template` resource specifies an email template.

## Syntax

Ensure that the template exists.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      it { should exist }
    end

## Parameters

`template_name` _(required)_

The name of the template.

For additional information, see the [AWS documentation on AWS SES Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html).

## Properties

| Property | Description |
| :---: | :--- |
| template_name | The name of the template. |
| subject_part | The subject line of the email. |
| text_part | The email body that will be visible to recipients whose email clients do not display HTML. |
| html_part | The HTML body of the email. |

## Examples

### Ensure a template name is available.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      its('template_name') { should eq 'TEMPLATE_NAME' }
    end

### Ensure a subject is available in the template.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      its('subject_part') { should eq 'HTML_SUBJECT' }
    end

### Ensure a text part is available in the template.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      its('text_part') { should eq 'HTML_TEXT_PART' }
    end

### Ensure an HTML body is available in the template.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      its('html_part') { should eq 'HTML_PART' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SES:Client:GetTemplateResponse` action with `Effect` set to `Allow`.
