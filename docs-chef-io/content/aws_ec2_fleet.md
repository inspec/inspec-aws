+++
title = "aws_ec2_fleet resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_fleet"
identifier = "inspec/resources/aws/aws_ec2_fleet resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_fleet` InSpec audit resource to test properties of a single AWS EC2 fleet.

The `AWS::EC2::SpotFleet` resource specifies the configuration information to launch a fleet--or group--of instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-ec2fleet.html).

## Syntax

Ensure that the fleet ID exists.

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
  it { should exist }
end
```

## Parameters

`fleet_id` _(required)_

: The ID of the EC2 Fleet.

## Properties

`activity_status`
: The progress of the EC2 Fleet.

`create_time`
: The creation date and time of the EC2 Fleet.

`fleet_id`
: The ID of the EC2 Fleet.

`fleet_state`
: The state of the EC2 Fleet.

`client_token`
: Unique, case-sensitive identifier that you provide to ensure the idempotency of the request.

`excess_capacity_termination_policy`
: Indicates whether running instances should be terminated if the target capacity of the EC2 Fleet is decreased below the current size of the EC2 Fleet.

`fulfilled_capacity`
: The number of units fulfilled by this request compared to the set target capacity.

`fulfilled_on_demand_capacity`
: The number of units fulfilled by this request compared to the set target On-Demand capacity.

`launch_template_configs`
: The launch template and overrides.

`target_capacity_specification.total_target_capacity`
: The number of units to request.

`target_capacity_specification.on_demand_target_capacity`
: The number of On-Demand units to request.

`target_capacity_specification.spot_target_capacity`
: The maximum number of Spot units to launch.

`target_capacity_specification.default_target_capacity_type`
: The default TotalTargetCapacity , which is either Spot or On-Demand.

`terminate_instances_with_expiration`
: Indicates whether running instances should be terminated when the EC2 Fleet expires.

`type`
: The type of request.

`valid_from`
: The start date and time of the request.

`valid_until`
: The end date and time of the request.

`replace_unhealthy_instances`
: Indicates whether EC2 Fleet should replace unhealthy Spot Instances.

`spot_options.allocation_strategy`
: Indicates how to allocate the target Spot Instance capacity across the Spot Instance pools specified by the EC2 Fleet.

`spot_options.maintenance_strategies.capacity_rebalance.replacement_strategy`
: To allow EC2 Fleet to launch a replacement Spot Instance when an instance rebalance notification is emitted for an existing Spot Instance in the fleet, specify launch.

`spot_options.instance_interruption_behavior`
: The behavior when a Spot Instance is interrupted.

`spot_options.instance_pools_to_use_count`
: The number of Spot pools across which to allocate your target Spot capacity.

`spot_options.single_instance_type`
: Indicates that the fleet uses a single instance type to launch all Spot Instances in the fleet.

`spot_options.single_availability_zone`
: Indicates that the fleet launches all Spot Instances into a single Availability Zone.

`spot_options.min_target_capacity`
: The minimum target capacity for Spot Instances in the fleet.

`spot_options.max_total_price`
: The maximum target capacity for Spot Instances in the fleet.

`on_demand_options.allocation_strategy`
: The order of the launch template overrides to use in fulfilling On-Demand capacity.

`on_demand_options.capacity_reservation_options.usage_strategy`
: If you specify use-capacity-reservations-first , the fleet uses unused Capacity Reservations to fulfill On-Demand capacity up to the target On-Demand capacity.

`on_demand_options.single_instance_type`
: Indicates that the fleet uses a single instance type to launch all On-Demand Instances in the fleet.

`on_demand_options.single_availability_zone`
: Indicates that the fleet launches all On-Demand Instances into a single Availability Zone.

`on_demand_options.min_target_capacity`
: The minimum target capacity for On-Demand Instances in the fleet.

`on_demand_options.max_total_price`
: The maximum amount per hour for On-Demand Instances that you're willing to pay.

`tags`
: The tags for an EC2 Fleet resource.

`errors`
: Information about the instances that could not be launched by the fleet.

`instances`
: Information about the instances that were launched by the fleet.

`context`
: The context.

## Examples

**Ensure a fleet ID is available.**

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
  its('fleet_id') { should eq 'FLEET_ID' }
end
```

**Ensure that the type is `instant`.**

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
    its('type') { should eq 'instant' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_fleet(fleet_id: "FLEET_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeFleetsResult" %}}
