---
title: About the aws_ssm_documents Resource
platform: aws
---

# aws\_ssm\_documents

Use the `aws_ssm_documents` InSpec audit resource to test properties of a collection of AWS SSM Compliance Items.

## Syntax

 Ensure you have exactly 3 documents

    describe aws_ssm_documents do
      its('names.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on SSM](https://docs.aws.amazon.com/systems-manager/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|names                        | Provides the name of the Systems Manager document. |
|owners                       | Provides the AWS user account that created the document. |
|platform\_types              | Provides the list of OS platforms compatible with this Systems Manager document. |
|document\_versions           | Provides the document version. |
|document\_types              | Provides the type of the document. |
|schema\_versions             | Provides the schema version. |
|document\_formats            | Provides the document format, either JSON or YAML. |
|target\_types                | The target type which defines the kinds of resources the document can run on. |
|tags                         | Provides the tags, or metadata, that have been applied to the document. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DocumentDescription.html).

## Examples

##### Ensure a Name of a SSM Document exists
    describe aws_ssm_documents do
      its('names') { should include 'document-name' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_documents.where( <property>: <value> ) do
      it { should exist }
    end

    describe aws_ssm_documents.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:ListDocuments` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).