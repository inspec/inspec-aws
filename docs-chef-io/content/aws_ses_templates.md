+++
title = "aws_ses_templates resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ses_templates"
identifier = "inspec/resources/aws/aws_ses_templates resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ses_templates` InSpec audit resource to test properties of multiple AWS Simple Email Service (SES) templates.

The `AWS::SES::Template` resource specifies an email template.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SES Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html).

## Syntax

Ensure that the template exists.

```ruby
describe aws_ses_templates do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The name of the template.

: **Field**: `name`

`created_timestamps`
: The time and date the template was created.

: **Field**: `created_timestamp`

## Examples

Ensure a template name is available:

```ruby
describe aws_ses_templates do
  its('names') { should include 'TEMPLATE_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ses_templates do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ses_templates do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SES:Client:ListTemplatesResponse" %}}
