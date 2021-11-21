---
title: About the aws_ram_resource_shares Resource
platform: aws
---

# aws\_ram\_resource\_shares

Use the `aws_ram_resource_shares` InSpec audit resource to test properties of multiple AWS RAM resource shares.

## Syntax

Ensure that a resource exists.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should exist }
    end

## Parameters

`resource_owner` _(required)_

The type of owner. Possible values: `SELF` and `OTHER-ACCOUNTS`.

For additional information, see the [AWS documentation on AWS RAM Resource Share](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html).

## Properties

| Property | Description|
| --- | --- |
| resource_share_arns | The Amazon Resource Name (ARN) of the resource share. |
| names | The name of the resource share. |
| owning_account_ids | The ID of the AWS account that owns the resource share. |
| allow_external_principals | Indicates whether principals outside your AWS organization can be associated with a resource share. |
| statuses | The status of the resource share. |
| status_messages | A message about the status of the resource share. |
| tags | The tags for the resource share. |
| creation_times | The time when the resource share was created. |
| last_updated_times | The time when the resource share was last updated. |
| feature_sets | Indicates how the resource share was created. Possible values include `CREATED_FROM_POLICY`, `PROMOTING_TO_STANDARD`, and `STANDARD`. |

## Examples

### Ensure a resource ARN is available.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      its('resource_share_arns') { should include 'RESOURCE_SHARE_ARN' }
    end

### Ensure that a resource share has an `ACTIVE` status.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
        its('statuses') { should include 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ram_resource_shares(resource_owner: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the resource is available.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RAM:Client:GetResourceSharesResponse` action with `Effect` set to `Allow`.