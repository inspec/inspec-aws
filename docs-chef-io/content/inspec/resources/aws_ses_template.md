+++
title = "aws_ses_template Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ses_template"
identifier = "inspec/resources/aws/aws_ses_template Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ses_template` InSpec audit resource to test properties of a single AWS Simple Email Service (SES) template.

The `AWS::SES::Template` resource specifies an email template.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SES Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the template exists.

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  it { should exist }
end
```

## Parameters

`template_name` _(required)_

: The name of the template.

## Properties

`template_name`
: The name of the template.

`subject_part`
: The subject line of the email.

`text_part`
: The email body that will be visible to recipients whose email clients do not display HTML.

`html_part`
: The HTML body of the email.

## Examples

**Ensure a template name is available.**

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  its('template_name') { should eq 'TEMPLATE_NAME' }
end
```

**Ensure a subject is available in the template.**

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  its('subject_part') { should eq 'HTML_SUBJECT' }
end
```

**Ensure a text part is available in the template.**

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  its('text_part') { should eq 'HTML_TEXT_PART' }
end
```

**Ensure an HTML body is available in the template.**

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  its('html_part') { should eq 'HTML_PART' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ses_template(template_name: 'TEMPLATE_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SES:Client:GetTemplateResponse" %}}
