+++
title = "aws_ec2_spot_fleets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_spot_fleets"
identifier = "inspec/resources/aws/aws_ec2_spot_fleets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_spot_fleets` InSpec audit resource to test properties of the plural AWS EC2 Spot Fleet.

The `AWS::EC2::SpotFleet` resource specifies a Spot Fleet request. A Spot Fleet request contains the configuration information to launch a fleet, or group, of instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Spot Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html).

## Syntax

Ensure that spot fleets exists.

```ruby
describe aws_ec2_spot_fleets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`activity_statuses`
: The progress of the Spot Fleet request.

: **Field**: `activity_status`

`create_times`
: The creation date and time of the request.

: **Field**: `create_time`

`spot_fleet_request_configs`
: The configs of the Spot Fleet request.

: **Field**: `spot_fleet_request_config`

`spot_fleet_request_ids`
: The ID of the Spot Fleet request.

: **Field**: `spot_fleet_request_id`

`spot_fleet_request_states`
: The state of the Spot Fleet request.

: **Field**: `spot_fleet_request_state`

`tags`
: The tags for a Spot Fleet resource.

: **Field**: `tags`

## Examples

**Ensure an activity status is there.**

```ruby
describe aws_ec2_spot_fleets do
  its('activity_statuses') { should include 'error' }
end
```

**Ensure that the state is `active`.**

```ruby
describe aws_ec2_spot_fleets do
    its('spot_fleet_request_states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_spot_fleets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_spot_fleets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeSpotFleetRequestsResponse" %}}
