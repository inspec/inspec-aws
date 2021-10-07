---
title: About the aws_ec2_prefix_lists Resource
platform: aws
---

# aws_ec2_prefix_lists

Use the `aws_ec2_prefix_lists` InSpec audit resource to test properties of multiple AWS EC2 prefix lists.

The `AWS::EC2::PrefixList` resource specifies a managed prefix list.

## Syntax

Ensure that a prefix list exists.

    describe aws_ec2_prefix_lists do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS EC2 prefix lists](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist.html).

## Properties

| Property | Description | Description |
| --- | --- | --- |
| prefix_list_ids | The ID of the prefix list. | prefix_list_id |
| address_families | The IP address version. | address_family |
| states | The state of the prefix list. | state |
| state_messages | The state message. | state_message |
| prefix_list_arns | The Amazon Resource Name (ARN) for the prefix list. | prefix_list_arn |
| prefix_list_names | The name of the prefix list. | prefix_list_name |
| max_entries | The maximum number of entries for the prefix list. | max_entries |
| versions | The version of the prefix list. | version |
| tags | The tags for the prefix list. | tags |
| owner_ids | The ID of the owner of the prefix list. | owner_id |

## Examples

### Ensure a prefix list ID is available.

    describe aws_ec2_prefix_lists do
      its('prefix_list_ids') { should include 'PREFIX_LIST_ID' }
    end

### Ensure an address family is available.

    describe aws_ec2_prefix_lists do
      its('address_families') { should include 'ADDRESS_FAMILY' }
    end

### Ensure that the state is `AVAILABLE`.

    describe aws_ec2_prefix_lists do
        its('states') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_prefix_lists do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_prefix_lists do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeManagedPrefixListsResult` action with `Effect` set to `Allow`.
