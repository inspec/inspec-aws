---
title: About the aws_ec2_network_interface_permission Resource
platform: aws
---

# aws_ec2_network_interface_permission

Use the `aws_ec2_network_interface_permission` InSpec audit resource to test the properties of a single specific AWS EC2 network interface permission.

## Syntax

Ensure that network interface permission ID exists.

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
      it { should exist }
    end

## Parameters

`network_interface_permission_id` _(required)_

: The ID of the network interface permission.

For additional information, see the [AWS documentation on AWS EC2 Network Interface Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html).

## Properties

| Property | Description | 
| --- | --- |
| network_interface_permission_id | The ID of the network interface. |
| network_interface_id |  The Amazon Web Services account ID. |
| aws_account_id |The Amazon Web Service. Currently not supported. |
| state |The state of the permission.  Valid values are: "pending", "granted", "revoking", "revoked". |
| status_message | The status message of the permission state. |

## Examples

### Ensure a network interface permission ID is available

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
      its('network_interface_permission_id') { should eq 'NETWORK_INTERFACE_PERMISSION_ID' }
    end

### Ensure that the interface permission state is 'pending'

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
        its('state') { should eq 'pending' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacePermissionsResult` action with `Effect` set to `Allow`.
