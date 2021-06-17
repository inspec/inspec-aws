---
title: About the aws_ram_resource_shares Resource
platform: aws
---

# aws\_ram\_resource\_shares

Use the `aws_ram_resource_shares` InSpec audit resource to test properties of a plural AWS RAM Resource Shares.

The AWS::RAM::ResourceShare resource specifies a resource share.

## Syntax

Ensure that a resource exists.

    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should exist }
    end

## Parameters

`resource_owner` _(required)_

For additional information, see the [AWS documentation on AWS RAM Resource Share](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html).

## Properties

| Property | Description|
| --- | --- |
| arns | The Amazon Resource Name (ARN) of the resource. |
| types | The resource type. |
| resource_share_arns | The Amazon Resource Name (ARN) of the resource share. |
| resource_share_arns | The ARN of the resource group. This value is returned only if the resource is a resource group. |
| statuses | The status of the resource. |
| status_messages | A message about the status of the resource. |
| creation_times | The time when the resource was associated with the resource share. |
| last_updated_times | The time when the association was last updated. |

## Examples

### Ensure a resource arn is available.
    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      its('arns') { should include 'resource_arn_test' }
    end

### Ensure a resource group arn is available.
    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      its('resource_group_arns') { should include 'resource_group_arn_test' }
    end

### Ensure that the status is `AVAILABLE` or `ZONAL_RESOURCE_INACCESSIBLE`.
    describe aws_ram_resource_shares(resource_owner: 'SELF') do
        its('states') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ram:client:list_resources` action with `Effect` set to `Allow`.