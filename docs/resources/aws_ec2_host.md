---
title: About the aws_ec2_host Resource
platform: aws
---

# aws_ec2_host

Use the `aws_ec2_host` InSpec audit resource to test properties of a single specific AWS EC2 Host.

The AWS::EC2::Host resource allocates a fully dedicated physical server for launching EC2 instances.

## Syntax

Ensure that the host exists.

    describe aws_ec2_host(host_id: 'DedicatedHostId') do
      it { should exist }
    end

## Parameters

`host_id` _(required)_

| Property | Description |
| --- | --- |
| host_id | The ID of the Dedicated Host. |

For additional information, see the [AWS documentation on AWS EC2 Host.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| auto_placement | Whether auto-placement is on or off. | auto_placement |
| availability_zone | The Availability Zone of the Dedicated Host. | availability_zone |
| available_capacity.available_instance_capacity | The number of instances that can be launched onto the Dedicated Host based on the host's available capacity. | available_instance_capacity |
| available_capacity.available_v_cpus | The number of vCPUs available for launching instances onto the Dedicated Host. | available_v_cpus |
| client_token | Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. | client_token |
| host_id | The ID of the Dedicated Host. | host_id |
| host_properties.cores | The number of cores on the Dedicated Host. | cores |
| host_properties.instance_type | The instance type supported by the Dedicated Host. | instance_type |
| host_properties.instance_family | The instance family supported by the Dedicated Host. | instance_family |
| host_properties.sockets | The number of sockets on the Dedicated Host. | sockets |
| host_properties.total_v_cpus | The total number of vCPUs on the Dedicated Host. | total_v_cpus |
| host_reservation_id | The reservation ID of the Dedicated Host. | host_reservation_id |
| instances | The IDs and instance type that are currently running on the Dedicated Host. | instances |
| state | The Dedicated Host's state. | state |
| allocation_time | The time that the Dedicated Host was allocated. | allocation_time |
| release_time | The time that the Dedicated Host was released. | release_time |
| tags | Any tags assigned to the Dedicated Host. | tags |
| host_recovery | Indicates whether host recovery is enabled or disabled for the Dedicated Host. | host_recovery |
| allows_multiple_instance_types | Indicates whether the Dedicated Host supports multiple instance types of the same instance family. | allows_multiple_instance_types |
| owner_id | The ID of the Amazon Web Services account that owns the Dedicated Host. | owner_id |
| availability_zone_id | The ID of the Availability Zone in which the Dedicated Host is allocated. | availability_zone_id |
| member_of_service_linked_resource_group | Indicates whether the Dedicated Host is in a host resource group. | member_of_service_linked_resource_group |

## Examples

### Ensure a host is available.
    describe aws_ec2_host(host_id: 'DedicatedHostId') do
      its('host_id') { should eq 'DedicatedHostId' }
    end

### Ensure that the state is `available`.
    describe aws_ec2_host(host_id: 'DedicatedHostId') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_host(host_id: 'DedicatedHostId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_host(host_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_host(host_id: 'DedicatedHostId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeHostsResult` action with `Effect` set to `Allow`.