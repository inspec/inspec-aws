+++
title = "aws_network_manager_devices Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_network_manager_devices"
identifier = "inspec/resources/aws/aws_network_manager_devices Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_manager_devices` InSpec audit resource to test properties of multiple AWS Network Manager devices.

The `AWS::NetworkManager::Device` resource gets information about one or more of your devices in a global network.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Manager Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a device exists.

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should exist }
end
```

## Parameters

`global_network_id` _(required)_

: The ID of the global network.

## Properties

`device_ids`
: The ID of the device.

: **Field**: `device_id`

`device_arns`
: The Amazon Resource Name (ARN) of the device.

: **Field**: `device_arn`

`global_network_ids`
: The ID of the global network.

: **Field**: `global_network_id`

`location_zones`
: The Zone the device is located in. This can be the ID of an Availability Zone, Local Zone, Wavelength Zone, or an Outpost.

: **Field**: `zone`

`location_subnet_arns`
: The Amazon Resource Name (ARN) of the subnet the device is located in.

: **Field**: `subnet_arn`

`descriptions`
: The description of the device.

: **Field**: `description`

`types`
: The device type.

: **Field**: `type`

`vendors`
: The device vendor.

: **Field**: `vendor`

`models`
: The device model.

: **Field**: `model`

`addresses`
: The physical address of the location.

: **Field**: `address`

`latitudes`
: The latitude of the location.

: **Field**: `latitude`

`longitudes`
: The longitude of the location.

: **Field**: `longitude`

`site_ids`
: The site ID.

: **Field**: `site_id`

`created_at`
: The date and time that the site was created.

: **Field**: `created_at`

`states`
: The device state.

: **Field**: `state`

`tags`
: The tags for the device.

: **Field**: `tags`

## Examples

**Ensure a device ID is available.**

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  its('device_ids') { should include 'DEVICE_ID' }
end
```

**Ensure a global network ID is available.**

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  its('global_network_ids') { should include 'GLOBAL_NETWORK_ID' }
end
```

**Ensure a location zone is available.**

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  its('location_zones') { should include 'ZONE_NAME' }
end
```

**Ensure that the state is `AVAILABLE`.**

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
    its('states') { should include 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_manager_devices(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkManager:Client:GetDevicesResponse" %}}
