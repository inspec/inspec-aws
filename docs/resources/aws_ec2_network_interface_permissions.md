---
title: About the aws_ec2_network_interface_permissions Resource
platform: aws
---

# aws_ec2_network_interface_permissions

Use the `aws_ec2_network_interface_permissions` InSpec audit resource to test properties of multiple AWS EC2 network interface permission.

## Syntax

Ensure that network interface permission ID exists.

    describe aws_ec2_network_interface_permissions do
      it { should exist }
    end

For additional information, see the [AWS documentation on AWS EC2 Network Interface Permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html).

## Parameters

This resource does not expect any parameters.

## Properties

| Property | Description | Field |
| --- | --- | --- |
| network_interface_permission_ids | The ID of the network interface. | network_interface_permission_id |
| network_interface_ids |  The Amazon Web Services account ID. | network_interface_id |
| aws_account_ids |The Amazon Web Service. Currently not supported. | aws_account_id|
| states |The state of the permission.  String, one of "pending", "granted", "revoking", "revoked". | state |
| status_messages | The status message of the permission state. | status_message |

## Examples

### Ensure a network interface permission ID is available

    describe aws_ec2_network_interface_permissions do
      its('network_interface_permission_ids') { should include 'NETWORK_INTERFACE_PERMISSION_ID' }
    end

### Ensure that the interface permission state is 'pending'

    describe aws_ec2_network_interface_permissions do
        its('states') { should include 'pending' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface_permissions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface_permissions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_interface_permissions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacePermissionsResult` action with `Effect` set to `Allow`.
