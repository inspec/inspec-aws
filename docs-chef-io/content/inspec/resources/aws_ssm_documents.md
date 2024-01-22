+++
title = "aws_ssm_documents Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ssm_documents"
identifier = "inspec/resources/aws/aws_ssm_documents Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_documents` InSpec audit resource to test properties of a collection of AWS SSM Compliance Items.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 Ensure you have exactly 3 documents

```ruby
describe aws_ssm_documents do
  its('names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: Provides the name of the Systems Manager document.

`owners`
: Provides the AWS user account that created the document.

`platform_types`
: Provides the list of OS platforms compatible with this Systems Manager document.

`document_versions`
: Provides the document version.

`document_types`
: Provides the type of the document.

`schema_versions`
: Provides the schema version.

`document_formats`
: Provides the document format, either JSON or YAML.

`target_types`
: The target type which defines the kinds of resources the document can run on.

`tags`
: Provides the tags, or metadata, that have been applied to the document.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DocumentDescription.html).

## Examples

**Ensure a Name of a SSM Document exists.**

```ruby
describe aws_ssm_documents do
  its('names') { should include 'document-name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_documents.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_ssm_documents.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:ListDocumentsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).