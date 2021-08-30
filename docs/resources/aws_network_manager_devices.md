---
title: About the aws_network_manager_devices Resource
platform: aws
---

# aws_network_manager_devices

Use the `aws_network_manager_devices` InSpec audit resource to test properties of a plural resource of AWS Network Manager Device.

The AWS::NetworkManager::Device resource gets information about one or more of your devices in a global network.

## Syntax

Ensure that a device exists.

    describe aws_network_manager_devices do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Network Manager Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html).

## Properties

| Property | Description | Description |
| --- | --- | --- |
| device_ids | The ID of the device. | device_id |
| device_arns | The Amazon Resource Name (ARN) of the device. | device_arn |
| global_network_ids | The ID of the global network. | global_network_id |
| aws_locations | The aws locations. | aws_location |
| descriptions | The description of the device. | description |
| types | The device type. | type |
| vendors | The device vendor. | vendor |
| models | The device model. | model |
| locations | The location. | location |
| site_ids | The site ID. | site_id |
| created_at | The date and time that the site was created. | created_at |
| states | The device state. | state |
| tags | The tags for the device. | tags |

## Examples

### Ensure a Device ID is available.
    describe aws_network_manager_devices do
      its('device_id') { should include 'DeviceID' }
    end

### Ensure a Global Network ID is available.
    describe aws_network_manager_devices do
      its('global_network_id') { should include 'GlobalNetworkID' }
    end

### Ensure a zone is available.
    describe aws_network_manager_devices do
      its('aws_location.zone') { should include 'ZoneName' }
    end

### Ensure that the state is `AVAILABLE`.
    describe aws_network_manager_devices do
        its('state') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `gets` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_devices do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_devices do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:GetDevicesResponse` action with `Effect` set to `Allow`.