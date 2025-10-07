+++
title = "aws_ec2_capacity_reservations resource"

draft = false


[menu.aws]
title = "aws_ec2_capacity_reservations"
identifier = "inspec/resources/aws/aws_ec2_capacity_reservations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_capacity_reservations` InSpec audit resource to test properties of the plural resource of AWS EC2 Capacity Reservation.

The `AWS::EC2::CapacityReservation` resource type creates a new Capacity Reservation with the specified attributes.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Capacity Reservation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html).

## Syntax

Ensure that the Capacity Reservation ID exists.

```ruby
describe aws_ec2_capacity_reservations do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`capacity_reservation_ids`
: The ID of the Capacity Reservation.

: **Field**: `capacity_reservation_id`

`owner_ids`
: The ID of the Amazon Web Services account that owns the Capacity Reservation.

: **Field**: `owner_id`

`capacity_reservation_arns`
: The Amazon Resource Name (ARN) of the Capacity Reservation.

: **Field**: `capacity_reservation_arn`

`availability_zone_ids`
: The Availability Zone ID of the Capacity Reservation.

: **Field**: `availability_zone_id`

`instance_types`
: The type of instance for which the Capacity Reservation reserves capacity.

: **Field**: `instance_type`

`instance_platforms`
: The type of operating system for which the Capacity Reservation reserves capacity.

: **Field**: `instance_platform`

`availability_zones`
: The Availability Zone in which the capacity is reserved.

: **Field**: `availability_zone`

`tenancies`
: Indicates the tenancy of the Capacity Reservation.

: **Field**: `tenancy`

`total_instance_counts`
: The total number of instances for which the Capacity Reservation reserves capacity.

: **Field**: `total_instance_count`

`available_instance_counts`
: The remaining capacity.

: **Field**: `available_instance_count`

`ebs_optimized`
: Indicates whether the Capacity Reservation supports EBS-optimized instances.

: **Field**: `ebs_optimized`

`ephemeral_storages`
: Indicates whether the Capacity Reservation supports instances with temporary, block-level storage.

: **Field**: `ephemeral_storage`

`states`
: The current state of the Capacity Reservation.

: **Field**: `state`

`start_dates`
: The date and time at which the Capacity Reservation was started.

: **Field**: `start_date`

`end_dates`
: The date and time at which the Capacity Reservation expires.

: **Field**: `end_date`

`end_date_types`
: Indicates the way in which the Capacity Reservation ends.

: **Field**: `end_date_type`

`instance_match_criterias`
: Indicates the type of instance launches that the Capacity Reservation accepts.

: **Field**: `instance_match_criteria`

`create_dates`
: The date and time at which the Capacity Reservation was created.

: **Field**: `create_date`

`tags`
: Any tags assigned to the Capacity Reservation.

: **Field**: `tags`

`outpost_arns`
: The Amazon Resource Name (ARN) of the Outpost on which the Capacity Reservation was created.

: **Field**: `outpost_arn`

## Examples

Ensure a Capacity Reservation ID is available:

```ruby
describe aws_ec2_capacity_reservations do
  its('capacity_reservation_ids') { should include 'CAPACITY_RESERVATION_ID' }
end
```

Ensure that the state is `active`:

```ruby
describe aws_ec2_capacity_reservations do
    its('states') { should include 'active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_capacity_reservations do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_capacity_reservations do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCapacityReservationsResult" %}}
