---
title: About the aws_ec2_fleet Resource
platform: aws
---

# aws_ec2_fleet

Use the `aws_ec2_fleet` InSpec audit resource to test properties of a single specific AWS EC2 Fleet.

The AWS::EC2::SpotFleet resource specifies the configuration information to launch a fleet--or group--of instances.

## Syntax

Ensure that the fleet id exists.

    describe aws_ec2_fleet(fleet_id: "FleetId") do
      it { should exist }
    end

## Parameters

`fleet_id` _(required)_

| Property | Description |
| --- | --- |
| fleet_id | The ID of the EC2 Fleet. |

For additional information, see the [AWS documentation on AWS EC2 Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-ec2fleet.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| activity_status | The progress of the EC2 Fleet. | activity_status |
| create_time | The creation date and time of the EC2 Fleet. | create_time |
| fleet_id | The ID of the EC2 Fleet. | fleet_id |
| fleet_state | The state of the EC2 Fleet. | fleet_state |
| client_token | Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. | client_token |
| excess_capacity_termination_policy | Indicates whether running instances should be terminated if the target capacity of the EC2 Fleet is decreased below the current size of the EC2 Fleet. | excess_capacity_termination_policy |
| fulfilled_capacity | The number of units fulfilled by this request compared to the set target capacity. | fulfilled_capacity |
| fulfilled_on_demand_capacity | The number of units fulfilled by this request compared to the set target On-Demand capacity. | fulfilled_on_demand_capacity |
| launch_template_configs | The launch template and overrides. | launch_template_configs |
| target_capacity_specification.total_target_capacity | The number of units to request. | total_target_capacity |
| target_capacity_specification.on_demand_target_capacity | The number of On-Demand units to request. | on_demand_target_capacity |
| target_capacity_specification.spot_target_capacity | The maximum number of Spot units to launch. | spot_target_capacity |
| target_capacity_specification.default_target_capacity_type | The default TotalTargetCapacity , which is either Spot or On-Demand. | default_target_capacity_type |
| terminate_instances_with_expiration | Indicates whether running instances should be terminated when the EC2 Fleet expires. | terminate_instances_with_expiration |
| type | The type of request. | type |
| valid_from | The start date and time of the request. | valid_from |
| valid_until | The end date and time of the request. | valid_until |
| replace_unhealthy_instances | Indicates whether EC2 Fleet should replace unhealthy Spot Instances. | replace_unhealthy_instances |
| spot_options.allocation_strategy  | Indicates how to allocate the target Spot Instance capacity across the Spot Instance pools specified by the EC2 Fleet. | allocation_strategy |
| spot_options.maintenance_strategies.capacity_rebalance.replacement_strategy  | To allow EC2 Fleet to launch a replacement Spot Instance when an instance rebalance notification is emitted for an existing Spot Instance in the fleet, specify launch. | replacement_strategy |
| spot_options.instance_interruption_behavior  | The behavior when a Spot Instance is interrupted. | instance_interruption_behavior |
| spot_options.instance_pools_to_use_count  | The number of Spot pools across which to allocate your target Spot capacity. | instance_pools_to_use_count |
| spot_options.single_instance_type  | Indicates that the fleet uses a single instance type to launch all Spot Instances in the fleet. | single_instance_type |
| spot_options.single_availability_zone  | Indicates that the fleet launches all Spot Instances into a single Availability Zone. | single_availability_zone |
| spot_options.min_target_capacity  | The minimum target capacity for Spot Instances in the fleet. | min_target_capacity |
| spot_options.max_total_price  | The maximum target capacity for Spot Instances in the fleet. | max_total_price |
| on_demand_options.allocation_strategy | The order of the launch template overrides to use in fulfilling On-Demand capacity. | allocation_strategy |
| on_demand_options.capacity_reservation_options.usage_strategy | If you specify use-capacity-reservations-first , the fleet uses unused Capacity Reservations to fulfill On-Demand capacity up to the target On-Demand capacity. | usage_strategy |
| on_demand_options.single_instance_type | Indicates that the fleet uses a single instance type to launch all On-Demand Instances in the fleet. | activity_status |
| on_demand_options.single_availability_zone | Indicates that the fleet launches all On-Demand Instances into a single Availability Zone. | single_availability_zone |
| on_demand_options.min_target_capacity | The minimum target capacity for On-Demand Instances in the fleet. | min_target_capacity |
| on_demand_options.max_total_price | The maximum amount per hour for On-Demand Instances that you're willing to pay. | max_total_price |
| tags | The tags for an EC2 Fleet resource. | tags |
| errors | Information about the instances that could not be launched by the fleet. | errors |
| instances | Information about the instances that were launched by the fleet. | instances |
| context | Reserved. | context |

## Examples

### Ensure a fleet id is available.
    describe aws_ec2_fleet(fleet_id: "FleetId") do
      its('fleet_id') { should eq 'FleetId' }
    end

### Ensure that the type is `instant`.
    describe aws_ec2_fleet(fleet_id: "FleetId") do
        its('type') { should eq 'instant' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_fleet(fleet_id: "FleetId") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_fleet(fleet_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_fleet(fleet_id: "FleetId") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeFleetsResult` action with `Effect` set to `Allow`.