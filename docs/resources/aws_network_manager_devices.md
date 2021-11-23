---
title: About the aws_network_manager_devices Resource
platform: aws
---

# aws_network_manager_devices

Use the `aws_network_manager_devices` InSpec audit resource to test properties of multiple AWS Network Manager devices.

The `AWS::NetworkManager::Device` resource gets information about one or more of your devices in a global network.

## Syntax

Ensure that a device exists.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should exist }
    end

## Parameters

`global_network_id` _(required)_

The ID of the global network.

For additional information, see the [AWS documentation on AWS Network Manager Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| device_ids | The ID of the device. | device_id |
| device_arns | The Amazon Resource Name (ARN) of the device. | device_arn |
| global_network_ids | The ID of the global network. | global_network_id |
| location_zones | The Zone the device is located in. This can be the ID of an Availability Zone, Local Zone, Wavelength Zone, or an Outpost. | zone |
| location_subnet_arns | The Amazon Resource Name (ARN) of the subnet the device is located in. | subnet_arn |
| descriptions | The description of the device. | description |
| types | The device type. | type |
| vendors | The device vendor. | vendor |
| models | The device model. | model |
| addresses | The physical address of the location. | address |
| latitudes | The latitude of the location. | latitude |
| longitudes | The longitude of the location. | longitude |
| site_ids | The site ID. | site_id |
| created_at | The date and time that the site was created. | created_at |
| states | The device state. | state |
| tags | The tags for the device. | tags |

## Examples

### Ensure a device ID is available.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      its('device_ids') { should include 'DEVICE_ID' }
    end

### Ensure a global network ID is available.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      its('global_network_ids') { should include 'GLOBAL_NETWORK_ID' }
    end

### Ensure a location zone is available.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      its('location_zones') { should include 'ZONE_NAME' }
    end

### Ensure that the state is `AVAILABLE`.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
        its('states') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:GetDevicesResponse` action with `Effect` set to `Allow`.
