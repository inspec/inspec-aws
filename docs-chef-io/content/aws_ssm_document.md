+++
title = "aws_ssm_document resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_document"
identifier = "inspec/resources/aws/aws_ssm_document resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_document` InSpec audit resource to test properties of a ssm document.

For additional information, including details on parameters and properties, see the [AWS documentation on SSM Documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html).

## Syntax

 An `aws_ssm_document` resource block uses the parameter to select a ssm document.

```ruby
describe aws_ssm_document(name: 'document-name-1234') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: This resource accepts a single parameter, the SSM Document Name.
  This can be passed either as a string or as a `name: 'value'` key-value entry in a hash.

## Properties

`sha_1`
: Provides the SHA1 hash of the document, which you can use for verification.

`hash`
: Provides the Sha256 or Sha1 hash created by the system when the document was created.

`hash_type`
: Provides the hash type of the document. Valid values include Sha256 or Sha1.

`name`
: Provides the name of the Systems Manager document.

`version_name`
: Provides the version of the artifact associated with the document.

`owner`
: Provides the AWS user account that created the document.

`created_date`
: Provides the date when the document was created.

`status`
: Provides the status of the Systems Manager document.

`status_information`
: Provides a message returned by AWS Systems Manager that explains the Status value.

`document_version`
: Provides the document version.

`description`
: Provides a description of the document.

`parameters`
: Provides a description of the parameters for a document. These parameters include DefaultValue, Description, Name and Type.

`platform_types`
: Provides the list of OS platforms compatible with this Systems Manager document.

`document_type`
: Provides the type of the document.

`schema_version`
: Provides the schema version.

`latest_version`
: Provides the latest version of the document.

`default_version`
: Provides the default version.

`document_format`
: Provides the document format, either JSON or YAML.

`target_type`
: The target type which defines the kinds of resources the document can run on.

`tags`
: Provides the tags, or metadata, that have been applied to the document.

`attachments_information`
: Provides details about the document attachments, including names, locations, sizes, and so on.

`requires`
: Provides a list of SSM documents required by a document.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DocumentDescription.html)

## Examples

Check the Name of a SSM Document:

```ruby
describe aws_ssm_document(name: 'document-name-1234') do
  its('name')  { should eq 'document-name-1234' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_document(name: 'document-name-1234') do
  it { should exist }
end
```

```ruby
describe aws_ssm_document(name: 'document-name-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeDocumentResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).
