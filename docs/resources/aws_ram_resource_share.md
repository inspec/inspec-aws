---
title: About the aws_ram_resource_share Resource
platform: aws
---

# aws\_ram\_resource\_share

Use the `aws_ram_resource_share` InSpec audit resource to test properties of a single specific AWS RAM Resource Share.

The AWS::RAM::ResourceShare resource specifies a resource share.

## Syntax

Ensure that a resource exists.

    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'resource_share_arn_test') do
      it { should exist }
    end

## Parameters

`resource_owner resource_share_arn` _(required)_

For additional information, see the [AWS documentation on AWS RAM Resource Share](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html).

## Properties

| Property | Description|
| --- | --- |
| resource_share_arn | The Amazon Resource Name (ARN) of the resource share. |
| name | The name of the resource share. |
| owning_account_id | The ID of the AWS account that owns the resource share. |
| allow_external_principals | Indicates whether principals outside your AWS organization can be associated with a resource share. |
| status | The status of the resource share. |
| status_message | A message about the status of the resource share. |
| tags | The tags for the resource share. |
| creation_time | The time when the resource share was created. |
| last_updated_time | The time when the resource share was last updated. |
| feature_set | Indicates how the resource share was created. Possible values include CREATED_FROM_POLICY, PROMOTING_TO_STANDARD and STANDARD. |

## Examples

### Ensure a resource share arn is available.
    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'resource_share_arn_test') do
      its('resource_share_arn') { should eq 'resource_share_arn_test' }
    end

### Ensure a resource name is available.
    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'resource_share_arn_test') do
        its('name') { should eq 'resource_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'resource_share_arn_test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: 'resource_share_arn_test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ram:client:get_resource_shares` action with `Effect` set to `Allow`.