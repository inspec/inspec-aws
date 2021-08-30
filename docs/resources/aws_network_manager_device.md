---
title: About the aws_network_manager_device Resource
platform: aws
---

# aws_network_manager_device

Use the `aws_network_manager_device` InSpec audit resource to test properties of a single specific AWS Network Manager Device.

The AWS::NetworkManager::Device resource gets information about one or more of your devices in a global network.

## Syntax

Ensure that a device exists.

    describe aws_network_manager_device(device_id: 'DeviceID') do
      it { should exist }
    end

## Parameters

`device_id` _(required)_

| Property | Description | Description |
| --- | --- | --- |
| device_id | The ID of the device. | device_id |

For additional information, see the [AWS documentation on AWS Network Manager Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html).

## Properties

| Property | Description | Description |
| --- | --- | --- |
| device_id | The ID of the device. | device_id |
| device_arn | The Amazon Resource Name (ARN) of the device. | device_arn |
| global_network_id | The ID of the global network. | global_network_id |
| aws_location.zone | The Zone the device is located in. This can be the ID of an Availability Zone, Local Zone, Wavelength Zone, or an Outpost. | zone |
| aws_location.subnet_arn | The Amazon Resource Name (ARN) of the subnet the device is located in. | device_id |
| description | The description of the device. | description |
| type | The device type. | type |
| vendor | The device vendor. | vendor |
| model | The device model. | model |
| serial_number | The device serial number. | serial_number |
| location.address | The physical address of the location. | address |
| location.latitude | The latitude of the location. | latitude |
| location.longitude | The longitude of the location. | longitude |
| site_id | The site ID. | site_id |
| created_at | The date and time that the site was created. | created_at |
| state | The device state. | state |
| tags | The tags for the device. | tags |

## Examples

### Ensure a Device ID is available.
    describe aws_network_manager_device(device_id: 'DeviceID') do
      its('device_id') { should eq 'DeviceID' }
    end

### Ensure a Global Network ID is available.
    describe aws_network_manager_device(device_id: 'DeviceID') do
      its('global_network_id') { should eq 'GlobalNetworkID' }
    end

### Ensure a zone is available.
    describe aws_network_manager_device(device_id: 'DeviceID') do
      its('aws_location.zone') { should eq 'ZoneName' }
    end

### Ensure that the state is `AVAILABLE`.
    describe aws_network_manager_global_network(device_id: 'GlobalNetworkID') do
        its('state') { should eq 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_device(device_id: 'DeviceID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_device(device_id: 'summy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_manager_device(device_id: 'DeviceID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:GetDevicesResponse` action with `Effect` set to `Allow`.