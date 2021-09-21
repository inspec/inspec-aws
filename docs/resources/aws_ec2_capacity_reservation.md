---
title: About the aws_ec2_capacity_reservation Resource
platform: aws
---

# aws_ec2_capacity_reservation

Use the `aws_ec2_capacity_reservation` InSpec audit resource to test properties of a single specific AWS EC2 Capacity Reservation.

The AWS::EC2::CapacityReservation resource creates a new Capacity Reservation with the specified attributes.

## Syntax

Ensure that the Capacity Reservation Id exists.

    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
      it { should exist }
    end

## Parameters

`capacity_reservation_id` _(required)_

| Property | Description |
| --- | --- |
| capacity_reservation_id | The ID of the Capacity Reservation. |

For additional information, see the [AWS documentation on AWS EC2 Capacity Reservation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| capacity_reservation_id | The ID of the Capacity Reservation. | capacity_reservation_id |
| owner_id | The ID of the Amazon Web Services account that owns the Capacity Reservation. | owner_id |
| capacity_reservation_arn | The Amazon Resource Name (ARN) of the Capacity Reservation. | capacity_reservation_arn |
| availability_zone_id | The Availability Zone ID of the Capacity Reservation. | availability_zone_id |
| instance_type | The type of instance for which the Capacity Reservation reserves capacity. | instance_type |
| instance_platform | The type of operating system for which the Capacity Reservation reserves capacity. | instance_platform |
| availability_zone | The Availability Zone in which the capacity is reserved. | availability_zone |
| tenancy | Indicates the tenancy of the Capacity Reservation. | tenancy |
| total_instance_count | The total number of instances for which the Capacity Reservation reserves capacity. | total_instance_count |
| available_instance_count | The remaining capacity. | available_instance_count |
| ebs_optimized | Indicates whether the Capacity Reservation supports EBS-optimized instances. | ebs_optimized |
| ephemeral_storage | Indicates whether the Capacity Reservation supports instances with temporary, block-level storage. | ephemeral_storage |
| state | The current state of the Capacity Reservation. | state |
| start_date | The date and time at which the Capacity Reservation was started. | start_date |
| end_date | The date and time at which the Capacity Reservation expires. | end_date |
| end_date_type | Indicates the way in which the Capacity Reservation ends. | end_date_type |
| instance_match_criteria | Indicates the type of instance launches that the Capacity Reservation accepts. | instance_match_criteria |
| create_date | The date and time at which the Capacity Reservation was created. | create_date |
| tags | Any tags assigned to the Capacity Reservation. | tags |
| outpost_arn | The Amazon Resource Name (ARN) of the Outpost on which the Capacity Reservation was created. | outpost_arn |


## Examples

### Ensure a Capacity Reservation Id is available.
    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
      its('capacity_reservation_id') { should eq 'CapacityReservationId' }
    end

### Ensure that the state is `active`.
    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
        its('state') { should eq 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CapacityReservationId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCapacityReservationsResult` action with `Effect` set to `Allow`.