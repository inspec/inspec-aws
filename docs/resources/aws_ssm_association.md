---
title: About the aws_ssm_association Resource
platform: aws
---

# aws\_ssm\_association

Use the `aws_ssm_association` InSpec audit resource to test properties of a ssm association.

## Syntax

 An `aws_ssm_association` resource block uses the parameter to select a ssm association.

    describe aws_ssm_association(association_id: 'association-id-1234') do
      it { should exist }
    end


#### Parameters

##### association_id _(required)_

This resource accepts a single parameter, the SSM Association ID.
This can be passed either as a string or as a `association_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on SSM Associations](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-state-assoc.html).


## Properties

|Property                     | Description|
| ---                         | --- |
|association\_id              | Provides the ID of the association. |
|association\_name            | Provides the name of the association. |
|association\_version         | Provides the version of the association. |
|document\_version            | Provides the document version used in the association. |
|instance\_id                 | Provides the id of the instance. |
|last\_execution\_date        | The date on which the association was last run. |
|name                         | The name of the Systems Manager document. |
|overview                     | Provides information about the association. |
|schedule\_expression         | A cron expression that specifies a schedule when the association runs. |
|targets                      | Provides the instances targeted by the request to create an association. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Association.html)

## Examples

##### Check the Name of a SSM Association

    describe aws_ssm_association(association_id: 'association-id-1234') do
      its('name')  { should eq 'association-name-1234' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_association(association_id: 'association-id-1234') do
      it { should exist }
    end

    describe aws_ssm_association(association_id: 'association-id-6789') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:DescribeAssociation` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).