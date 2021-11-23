---
title: About the aws_ec2_hosts Resource
platform: aws
---

# aws_ec2_hosts

Use the `aws_ec2_hosts` InSpec audit resource to test properties of multiple AWS EC2 host resources.

The `AWS::EC2::host` allocates a fully dedicated physical server for launching EC2 instances.

## Syntax

Ensure that the host exists.

    describe aws_ec2_hosts do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 host.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| auto_placements | Whether auto-placement is on or off. | auto_placement |
| availability_zones | The Availability Zone of the Dedicated host. | availability_zone |
| available_capacities | The number of instances that can be launched onto the Dedicated host depending on the host's available capacity. | available_instance_capacity |
| client_tokens | Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. | client_token |
| host_ids | The ID of the Dedicated host. | host_id |
| host_properties | The hardware specifications of the Dedicated host. | host_properties |
| host_reservation_ids | The reservation ID of the Dedicated host. | host_reservation_id |
| instances | The IDs and instance type that are currently running on the Dedicated host. | instances |
| states | The Dedicated host's state. | state |
| allocation_times | The time that the Dedicated host was allocated. | allocation_time |
| release_times | The time that the Dedicated host was released. | release_time |
| tags | Any tags assigned to the Dedicated host. | tags |
| host_recoveries | Indicates whether host recovery is enabled or disabled for the Dedicated host. | host_recovery |
| allows_multiple_instance_types | Indicates whether the Dedicated host supports multiple instance types of the same instance family. | allows_multiple_instance_types |
| owner_ids | The ID of the Amazon Web Services account that owns the Dedicated host. | owner_id |
| availability_zone_ids | The ID of the Availability Zone in which the Dedicated host is allocated. | availability_zone_id |
| member_of_service_linked_resource_groups | Indicates whether the Dedicated host is in a host resource group. | member_of_service_linked_resource_group |

## Examples

### Ensure a host is available.

    describe aws_ec2_hosts do
      its('host_ids') { should include 'DEDICATED_HOST_ID' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_hosts do
        its('states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_hosts do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_hosts do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_hosts do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeHostsResult` action with `Effect` set to `Allow`.
