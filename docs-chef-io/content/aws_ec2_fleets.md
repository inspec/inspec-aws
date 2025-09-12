+++
title = "aws_ec2_fleets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_fleets"
identifier = "inspec/resources/aws/aws_ec2_fleets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_fleets` InSpec audit resource to test properties multiple AWS EC2 fleets.

The `AWS::EC2::SpotFleet` resource specifies the configuration information to launch a fleet--or group--of instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-ec2fleet.html).

## Syntax

Ensure that the fleet id exists.

```ruby
describe aws_ec2_fleets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`activity_statuses`
: The progress of the EC2 Fleet.

: **Field**: `activity_status`

`create_times`
: The creation date and time of the EC2 Fleet.

: **Field**: `create_time`

`fleet_ids`
: The ID of the EC2 Fleet.

: **Field**: `fleet_id`

`fleet_states`
: The state of the EC2 Fleet.

: **Field**: `fleet_state`

`client_tokens`
: Unique, case-sensitive identifier that you provide to ensure the idempotency of the request.

: **Field**: `client_token`

`excess_capacity_termination_policies`
: Indicates whether running instances should be terminated if the target capacity of the EC2 Fleet is decreased below the current size of the EC2 Fleet.

: **Field**: `excess_capacity_termination_policy`

`fulfilled_capacities`
: The number of units fulfilled by this request compared to the set target capacity.

: **Field**: `fulfilled_capacity`

`fulfilled_on_demand_capacities`
: The number of units fulfilled by this request compared to the set target On-Demand capacity.

: **Field**: `fulfilled_on_demand_capacity`

`launch_template_configs`
: The launch template and overrides.

: **Field**: `launch_template_configs`

`target_capacity_specifications`
: The number of units to request.

: **Field**: `target_capacity_specifications`

`types`
: The type of request.

: **Field**: `type`

`valid_from`
: The start date and time of the request.

: **Field**: `valid_from`

`valid_until`
: The end date and time of the request.

: **Field**: `valid_until`

`replace_unhealthy_instances`
: Indicates whether EC2 Fleet should replace unhealthy Spot Instances.

: **Field**: `replace_unhealthy_instances`

`spot_options`
: The configuration of Spot Instances in an EC2 Fleet.

: **Field**: `spot_options`

`on_demand_options`
: The allocation strategy of On-Demand Instances in an EC2 Fleet.

: **Field**: `on_demand_options`

`tags`
: The tags for an EC2 Fleet resource.

: **Field**: `tags`

`errors`
: Information about the instances that could not be launched by the fleet.

: **Field**: `errors`

`instances`
: Information about the instances that were launched by the fleet.

: **Field**: `instances`

`context`
: Reserved.

: **Field**: `context`

## Examples

Ensure a fleet id is available:

```ruby
describe aws_ec2_fleets do
  its('fleet_ids') { should include 'FLEET_ID' }
end
```

Ensure that the type is `instant`:

```ruby
describe aws_ec2_fleets do
    its('types') { should include 'instant' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_fleets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_fleets do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_fleets do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeFleetsResult" %}}
