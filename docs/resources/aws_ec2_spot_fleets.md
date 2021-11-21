---
title: About the aws_ec2_spot_fleets Resource
platform: aws
---

# aws_ec2_spot_fleets

Use the `aws_ec2_spot_fleets` InSpec audit resource to test properties of the plural AWS EC2 Spot Fleet.

The `AWS::EC2::SpotFleet` resource specifies a Spot Fleet request. A Spot Fleet request contains the configuration information to launch a fleet, or group, of instances.

## Syntax

Ensure that spot fleets exists.

    describe aws_ec2_spot_fleets do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS EC2 Spot Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| activity_statuses | The progress of the Spot Fleet request. | activity_status |
| create_times | The creation date and time of the request. | create_time |
| spot_fleet_request_configs | The configs of the Spot Fleet request. | spot_fleet_request_config |
| spot_fleet_request_ids | The ID of the Spot Fleet request. | spot_fleet_request_id |
| spot_fleet_request_states | The state of the Spot Fleet request. | spot_fleet_request_state |
| tags | The tags for a Spot Fleet resource. | tags |

## Examples

### Ensure an activity status is there.

    describe aws_ec2_spot_fleets do
      its('activity_statuses') { should include 'error' }
    end

### Ensure that the state is `active`.

    describe aws_ec2_spot_fleets do
        its('spot_fleet_request_states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_spot_fleets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_spot_fleets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeSpotFleetRequestsResponse` action with `Effect` set to `Allow`.
