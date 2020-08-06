---
title: About the aws_ssm_associations Resource
platform: aws
---

# aws\_ssm\_associations

Use the `aws_ssm_associations` InSpec audit resource to test properties of a collection of AWS SSM Associations.

## Syntax

 Ensure you have exactly 3 associations

    describe aws_ssm_associations do
      its('names.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on SSM](https://docs.aws.amazon.com/systems-manager/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|association\_ids             | Provides the ID of the association. |
|association\_names           | Provides the name of the association. |
|association\_versions        | Provides the version of the association. |
|document\_versions           | Provides the document version used in the association. |
|instance\_ids                | Provides the id of the instance. |
|last\_execution\_dates       | The date on which the association was last run. |
|names                        | The name of the Systems Manager document. |
|overviews                    | Provides information about the association. |
|schedule\_expressions        | A cron expression that specifies a schedule when the association runs. |
|targets                      | Provides the instances targeted by the request to create an association. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Association.html)

## Examples

##### Ensure an Association ID of a SSM Association exists
    describe aws_ssm_associations do
      its('association_ids') { should include 'association-id' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_associations.where( <property>: <value> ) do
      it { should exist }
    end

    describe aws_ssm_associations.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:ListAssociations` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).