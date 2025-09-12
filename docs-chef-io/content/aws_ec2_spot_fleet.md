+++
title = "aws_ec2_spot_fleet resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_spot_fleet"
identifier = "inspec/resources/aws/aws_ec2_spot_fleet resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_spot_fleet` InSpec audit resource to test properties of a single specific AWS EC2 Spot Fleet.

The `AWS::EC2::SpotFleet` resource specifies a Spot Fleet request. A Spot Fleet request contains the configuration information to launch a fleet, or group, of instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Spot Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html).

## Syntax

Ensure that the spot fleet exists.

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: "SpotFleetID") do
  it { should exist }
end
```

## Parameters

`spot_fleet_request_id` _(required)_

: The ID of the Spot Fleet request.

## Properties

`activity_status`
: The progress of the Spot Fleet request.

: **Field**: `activity_status`

`create_time`
: The creation date and time of the request.

: **Field**: `create_time`

`spot_fleet_request_config.allocation_strategy`
: Indicates how to allocate the target Spot Instance capacity across the Spot Instance pools specified by the Spot Fleet request.

: **Field**: `spot_fleet_request_config.allocation_strategy`

`spot_fleet_request_config.on_demand_allocation_strategy`
: The order of the launch template overrides to use in fulfilling On-Demand capacity.

: **Field**: `spot_fleet_request_config.on_demand_allocation_strategy`

`spot_fleet_request_config.spot_maintenance_strategies.capacity_rebalance.replacement_strategy`
: The replacement strategy to use.

: **Field**: `spot_fleet_request_config.spot_maintenance_strategies.capacity_rebalance.replacement_strategy`

`spot_fleet_request_config.client_token`
: A unique, case-sensitive identifier that you provide to ensure the idempotency of your listings.

: **Field**: `spot_fleet_request_config.client_token`

`spot_fleet_request_config.excess_capacity_termination_policy`
: Indicates whether running Spot Instances should be terminated if you decrease the target capacity of the Spot Fleet request below the current size of the Spot Fleet.

: **Field**: `spot_fleet_request_config.excess_capacity_termination_policy`

`spot_fleet_request_config.fulfilled_capacity`
: The number of units fulfilled by this request compared to the set target capacity. You cannot set this value.

: **Field**: `spot_fleet_request_config.fulfilled_capacity`

`spot_fleet_request_config.on_demand_fulfilled_capacity`
: The number of On-Demand units fulfilled by this request compared to the set target On-Demand capacity.

: **Field**: `spot_fleet_request_config.on_demand_fulfilled_capacity`

`spot_fleet_request_config.iam_fleet_role`
: The Amazon Resource Name (ARN) of an Identity and Access Management (IAM) role that grants the Spot Fleet the permission to request, launch, terminate, and tag instances on your behalf.

: **Field**: `spot_fleet_request_config.iam_fleet_role`

`spot_fleet_request_config.launch_specifications`
: The launch specifications for the Spot Fleet request.

: **Field**: `spot_fleet_request_config.launch_specifications`

`spot_fleet_request_config.launch_template_configs`
: The launch template and overrides.

: **Field**: `spot_fleet_request_config.launch_template_configs`

`spot_fleet_request_config.spot_price`
: The maximum price per unit hour that you are willing to pay for a Spot Instance.

: **Field**: `spot_fleet_request_config.spot_price`

`spot_fleet_request_config.target_capacity`
: The number of units to request for the Spot Fleet.

: **Field**: `spot_fleet_request_config.target_capacity`

`spot_fleet_request_config.on_demand_target_capacity`
: The number of On-Demand units to request.

: **Field**: `spot_fleet_request_config.on_demand_target_capacity`

`spot_fleet_request_config.on_demand_max_total_price`
: The maximum amount per hour for On-Demand Instances that you're willing to pay.

: **Field**: `spot_fleet_request_config.on_demand_max_total_price`

`spot_fleet_request_config.spot_max_total_price`
: The maximum amount per hour for Spot Instances that you're willing to pay.

: **Field**: `spot_fleet_request_config.spot_max_total_price`

`spot_fleet_request_config.terminate_instances_with_expiration`
: Indicates whether running Spot Instances are terminated when the Spot Fleet request expires.

: **Field**: `spot_fleet_request_config.terminate_instances_with_expiration`

`spot_fleet_request_config.type`
: The type of request.

: **Field**: `spot_fleet_request_config.type`

`spot_fleet_request_config.valid_from`
: The start date and time of the request.

: **Field**: `spot_fleet_request_config.valid_from`

`spot_fleet_request_config.valid_until`
: The end date and time of the request.

: **Field**: `spot_fleet_request_config.valid_until`

`spot_fleet_request_config.replace_unhealthy_instances`
: Indicates whether Spot Fleet should replace unhealthy instances.

: **Field**: `spot_fleet_request_config.replace_unhealthy_instances`

`spot_fleet_request_config.instance_interruption_behavior`
: The behavior when a Spot Instance is interrupted. The default is terminate.

: **Field**: `spot_fleet_request_config.instance_interruption_behavior`

`spot_fleet_request_config.load_balancers_config.classic_load_balancers_config.classic_load_balancers`
: One or more Classic Load Balancers.

: **Field**: `spot_fleet_request_config.load_balancers_config.classic_load_balancers_config.classic_load_balancers`

`spot_fleet_request_config.load_balancers_config.target_groups_config.target_groups`
: One or more target groups.

: **Field**: `spot_fleet_request_config.load_balancers_config.target_groups_config.target_groups`

`spot_fleet_request_config.instance_pools_to_use_count`
: The number of Spot pools across which to allocate your target Spot capacity.

: **Field**: `spot_fleet_request_config.instance_pools_to_use_count`

`spot_fleet_request_config.context`
: Reserved.

: **Field**: `spot_fleet_request_config.context`

`spot_fleet_request_config.tag_specifications`
: The key-value pair for tagging the Spot Fleet request on creation.

: **Field**: `spot_fleet_request_config.tag_specifications`

`spot_fleet_request_id`
: The ID of the Spot Fleet request.

: **Field**: `spot_fleet_request_id`

`spot_fleet_request_state`
: The state of the Spot Fleet request.

: **Field**: `spot_fleet_request_state`

`tags`
: The tags for a Spot Fleet resource.

: **Field**: `tags`

## Examples

**Ensure a iam fleet role is available.**

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: "SpotFleetID") do
  its('iam_fleet_role') { should eq 'IAMFleetRole' }
end
```

**Ensure that the state is `active`.**

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: "SpotFleetID") do
    its('spot_fleet_request_state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: "SpotFleetID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_spot_fleet(spot_fleet_request_id: "SpotFleetID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeSpotFleetRequestsResponse" %}}
