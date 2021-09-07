---
title: About the aws_ec2_spot_fleet Resource
platform: aws
---

# aws_ec2_spot_fleet

Use the `aws_ec2_spot_fleet` InSpec audit resource to test properties of a single specific AWS APIGatewayV2 Spot Fleet.

The AWS::APIGatewayV2::SpotFleet resource Soumyo.

## Syntax

Ensure that the spot fleet exists.

    describe aws_ec2_spot_fleet do
      it { should exist }
    end

## Parameters

`spot_fleet_request_id` _(required)_

| Property | Description |
| --- | --- |
| spot_fleet_request_id | The ID of the Spot Fleet request. |

For additional information, see the [AWS documentation on AWS APIGatewayV2 Spot Fleet.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |
| activity_status | The | activity_status |


## Examples

### Ensure a iam fleet role is available.
    describe aws_ec2_spot_fleet do
      its('iam_fleet_role') { should eq 'IAMFleetRole' }
    end

### Ensure that the state is `active`.
    describe aws_ec2_spot_fleet do
        its('spot_fleet_request_state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_spot_fleet do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_spot_fleet do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGatewayV2:Client:DescribeSpotFleetRequestsResponse` action with `Effect` set to `Allow`.