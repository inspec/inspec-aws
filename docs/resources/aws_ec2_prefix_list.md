---
title: About the aws_ec2_prefix_list Resource
platform: aws
---

# aws_ec2_prefix_list

Use the `aws_ec2_prefix_list` InSpec audit resource to test properties of a single specific AWS EC2 prefix list.

The `AWS::EC2::PrefixList` resource specifies a managed prefix list.

## Syntax

Ensure that a prefix list exists.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      it { should exist }
    end

## Parameters

`prefix_list_id` _(required)_

The ID of the prefix list.

For additional information, see the [AWS documentation on AWS EC2 prefix lists](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist.html).

## Properties

| Property | Description |
| --- | --- |
| prefix_list_id | The ID of the prefix list. |
| address_family | The IP address version. |
| state | The state of the prefix list. |
| state_message | The state message. |
| prefix_list_arn | The Amazon Resource Name (ARN) for the prefix list. |
| prefix_list_name | The name of the prefix list. |
| max_entries | The maximum number of entries for the prefix list. |
| version | The version of the prefix list. |
| tags | The tags for the prefix list. |
| owner_id | The ID of the owner of the prefix list. |

## Examples

### Ensure a prefix list ID is available.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      its('prefix_list_id') { should eq 'PREFIX_LIST_ID' }
    end

### Ensure an address family is available.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      its('address_family') { should eq 'ADDRESS_FAMILY' }
    end

### Ensure that the state is `AVAILABLE`.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
        its('state') { should eq 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeManagedPrefixListsResult` action with `Effect` set to `Allow`.
