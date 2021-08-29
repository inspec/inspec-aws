---
title: About the aws_ec2_network_insights_paths Resource
platform: aws
---

# aws_ec2_network_insights_paths

Use the `aws_ec2_network_insights_paths` InSpec audit resource to test properties of a plural AWS EC2 Internet Gateway.

The AWS::EC2::NetworkInsightsPath resource specifies a path to analyze for reachability.

## Syntax

Ensure that Network Insights Path Id exists.

    describe aws_ec2_network_insights_paths do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 Network Insights Path](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html).

## Properties

| Property | Description|
| --- | --- |
| network_insights_path_ids | The ID of the path. | network_insights_path_id |
| network_insights_path_arns | The Amazon Resource Name (ARN) of the path. | network_insights_path_arn |
| created_dates | The time stamp when the path was created. | created_date |
| sources | The Amazon Web Services resource that is the source of the path. | source |
| destinations | The Amazon Web Services resource that is the destination of the path. | destination |
| source_ips | The IP address of the Amazon Web Services resource that is the source of the path. | source_ip |
| destination_ips | The IP address of the Amazon Web Services resource that is the destination of the path. | destination_ip |
| protocols | The protocol. | protocol |
| destination_ports | The destination port. | destination_port |
| tags | The tags associated with the path. | tags |

## Examples

### Ensure a Network Insights Path Id is available.
    describe aws_ec2_network_insights_paths do
      its('network_insights_path_ids') { should include 'NetworkInsightsPathId' }
    end

### Ensure a Network Insights Path ARN is available.
    describe aws_ec2_network_insights_paths do
        its('network_insights_path_arns') { should include 'NetworkInsightsPathARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_insights_paths do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_insights_paths do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInsightsPathsResult` action with `Effect` set to `Allow`.