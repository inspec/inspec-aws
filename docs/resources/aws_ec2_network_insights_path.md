---
title: About the aws_ec2_network_insights_path Resource
platform: aws
---

# aws_ec2_network_insights_path

Use the `aws_ec2_network_insights_path` InSpec audit resource to test properties of a single specific AWS EC2 path to analyze for reachability.

The `AWS::EC2::NetworkInsightsPath` resource specifies a path to analyze for reachability.

## Syntax

Ensure that network insights path ID exists.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
      it { should exist }
    end

## Parameters

`network_insights_path_id` _(required)_

The ID of the path.

For additional information, see the [AWS documentation on AWS EC2 network insights path](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html).

## Properties

| Property | Description |
| --- | --- |
| network_insights_path_id | The ID of the path. |
| network_insights_path_arn | The Amazon Resource Name (ARN) of the path. |
| created_date | The timestamp when the path was created. |
| source | The Amazon Web Services resource that is the source of the path. |
| destination | The Amazon Web Services resource that is the destination of the path. |
| source_ip | The IP address of the Amazon Web Services resource that is the source of the path. |
| destination_ip | The IP address of the Amazon Web Services resource that is the destination of the path. |
| protocol | The protocol. |
| destination_port | The destination port. |
| tags | The tags associated with the path. |

## Examples

### Ensure a network insights path ID is available.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
      its('network_insights_path_id') { should eq 'NETWORK_INSIGHTS_PATH_ID' }
    end

### Ensure a network insights path ARN is available.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
        its('network_insights_path_arn') { should eq 'NETWORK_INSIGHTS_PATH_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_insights_path(network_insights_path_id: 'NETWORK_INSIGHTS_PATH_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInsightsPathsResult` action with `Effect` set to `Allow`.
