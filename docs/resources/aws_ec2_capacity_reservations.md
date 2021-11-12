---
title: About the aws_ec2_capacity_reservations Resource
platform: aws
---

# aws_ec2_capacity_reservations

Use the `aws_ec2_capacity_reservations` InSpec audit resource to test properties of the plural resource of AWS EC2 Capacity Reservation.

The `AWS::EC2::CapacityReservation` resource type creates a new Capacity Reservation with the specified attributes.

## Syntax

Ensure that the Capacity Reservation ID exists.

    describe aws_ec2_capacity_reservations do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 Capacity Reservation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| capacity_reservation_ids | The ID of the Capacity Reservation. | capacity_reservation_id |
| owner_ids | The ID of the Amazon Web Services account that owns the Capacity Reservation. | owner_id |
| capacity_reservation_arns | The Amazon Resource Name (ARN) of the Capacity Reservation. | capacity_reservation_arn |
| availability_zone_ids | The Availability Zone ID of the Capacity Reservation. | availability_zone_id |
| instance_types | The type of instance for which the Capacity Reservation reserves capacity. | instance_type |
| instance_platforms | The type of operating system for which the Capacity Reservation reserves capacity. | instance_platform |
| availability_zones | The Availability Zone in which the capacity is reserved. | availability_zone |
| tenancies | Indicates the tenancy of the Capacity Reservation. | tenancy |
| total_instance_counts | The total number of instances for which the Capacity Reservation reserves capacity. | total_instance_count |
| available_instance_counts | The remaining capacity. | available_instance_count |
| ebs_optimized | Indicates whether the Capacity Reservation supports EBS-optimized instances. | ebs_optimized |
| ephemeral_storages | Indicates whether the Capacity Reservation supports instances with temporary, block-level storage. | ephemeral_storage |
| states | The current state of the Capacity Reservation. | state |
| start_dates | The date and time at which the Capacity Reservation was started. | start_date |
| end_dates | The date and time at which the Capacity Reservation expires. | end_date |
| end_date_types | Indicates the way in which the Capacity Reservation ends. | end_date_type |
| instance_match_criterias | Indicates the type of instance launches that the Capacity Reservation accepts. | instance_match_criteria |
| create_dates | The date and time at which the Capacity Reservation was created. | create_date |
| tags | Any tags assigned to the Capacity Reservation. | tags |
| outpost_arns | The Amazon Resource Name (ARN) of the Outpost on which the Capacity Reservation was created. | outpost_arn |

## Examples

### Ensure a Capacity Reservation ID is available.

    describe aws_ec2_capacity_reservations do
      its('capacity_reservation_ids') { should include 'CAPACITY_RESERVATION_ID' }
    end

### Ensure that the state is `active`.

    describe aws_ec2_capacity_reservations do
        its('states') { should include 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_capacity_reservations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_capacity_reservations do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCapacityReservationsResult` action with `Effect` set to `Allow`.
