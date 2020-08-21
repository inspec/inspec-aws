---
title: About the aws_ssm_document Resource
platform: aws
---

# aws\_ssm\_document

Use the `aws_ssm_document` InSpec audit resource to test properties of a ssm document.

## Syntax

 An `aws_ssm_document` resource block uses the parameter to select a ssm document.

    describe aws_ssm_document(name: 'document-name-1234') do
      it { should exist }
    end


#### Parameters

##### name _(required)_

This resource accepts a single parameter, the SSM Document Name.
This can be passed either as a string or as a `name: 'value'` key-value entry in a hash.

See also the [AWS documentation on SSM Documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html).


## Properties

|Property                     | Description|
| ---                         | --- |
|sha\_1                       | Provides the SHA1 hash of the document, which you can use for verification. |
|hash                         | Provides the Sha256 or Sha1 hash created by the system when the document was created. |
|hash\_type                   | Provides the hash type of the document. Valid values include Sha256 or Sha1. |
|name                         | Provides the name of the Systems Manager document. |
|version\_name                | Provides the version of the artifact associated with the document. |
|owner                        | Provides the AWS user account that created the document. |
|created\_date                | Provides the date when the document was created. |
|status                       | Provides the status of the Systems Manager document. |
|status\_information          | Provides a message returned by AWS Systems Manager that explains the Status value. |
|document\_version            | Provides the document version. |
|description                  | Provides a description of the document. |
|parameters                   | Provides a description of the parameters for a document. These parameters include DefaultValue, Description, Name and Type. |
|platform\_types              | Provides the list of OS platforms compatible with this Systems Manager document. |
|document\_type               | Provides the type of the document. |
|schema\_version              | Provides the schema version. |
|latest\_version              | Provides the latest version of the document. |
|default\_version             | Provides the default version. |
|document\_format             | Provides the document format, either JSON or YAML. |
|target\_type                 | The target type which defines the kinds of resources the document can run on. |
|tags                         | Provides the tags, or metadata, that have been applied to the document. |
|attachments\_information     | Provides details about the document attachments, including names, locations, sizes, and so on. |
|requires                     | Provides a list of SSM documents required by a document. |


For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DocumentDescription.html)

## Examples

##### Check the Name of a SSM Document

    describe aws_ssm_document(name: 'document-name-1234') do
      its('name')  { should eq 'document-name-1234' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_document(name: 'document-name-1234') do
      it { should exist }
    end

    describe aws_ssm_document(name: 'document-name-6789') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:DescribeDocument` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).