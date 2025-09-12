+++
title = "aws_ec2_capacity_reservation resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_capacity_reservation"
identifier = "inspec/resources/aws/aws_ec2_capacity_reservation resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_capacity_reservation` InSpec audit resource to test properties of the singular resource of AWS EC2 Capacity Reservation.

The `AWS::EC2::CapacityReservation` resource type creates a new Capacity Reservation with the specified attributes.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Capacity Reservation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html).

## Syntax

Ensure that the Capacity Reservation Id exists.

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
  it { should exist }
end
```

## Parameters

`capacity_reservation_id` _(required)_

: The ID of the Capacity Reservation.

## Properties

`capacity_reservation_id`
: The ID of the Capacity Reservation.

`owner_id`
: The ID of the Amazon Web Services account that owns the Capacity Reservation.

`capacity_reservation_arn`
: The Amazon Resource Name (ARN) of the Capacity Reservation.

`availability_zone_id`
: The Availability Zone ID of the Capacity Reservation.

`instance_type`
: The type of instance for which the Capacity Reservation reserves capacity.

`instance_platform`
: The type of operating system for which the Capacity Reservation reserves capacity.

`availability_zone`
: The Availability Zone in which the capacity is reserved.

`tenancy`
: Indicates the tenancy of the Capacity Reservation.

`total_instance_count`
: The total number of instances for which the Capacity Reservation reserves capacity.

`available_instance_count`
: The remaining capacity.

`ebs_optimized`
: Indicates whether the Capacity Reservation supports EBS-optimized instances.

`ephemeral_storage`
: Indicates whether the Capacity Reservation supports instances with temporary, block-level storage.

`state`
: The current state of the Capacity Reservation.

`start_date`
: The date and time at which the Capacity Reservation was started.

`end_date`
: The date and time at which the Capacity Reservation expires.

`end_date_type`
: Indicates the way in which the Capacity Reservation ends.

`instance_match_criteria`
: Indicates the type of instance launches that the Capacity Reservation accepts.

`create_date`
: The date and time at which the Capacity Reservation was created.

`tags`
: Any tags assigned to the Capacity Reservation.

`outpost_arn`
: The Amazon Resource Name (ARN) of the Outpost on which the Capacity Reservation was created.

## Examples

Ensure a Capacity Reservation ID is available:

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
  its('capacity_reservation_id') { should eq 'CAPACITY_RESERVATION_ID' }
end
```

Ensure that the state is `active`:

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
    its('state') { should eq 'active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_capacity_reservation(capacity_reservation_id: 'CAPACITY_RESERVATION_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCapacityReservationsResult" %}}
