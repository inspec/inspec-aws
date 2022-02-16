---
title: About the aws_ec2_network_insights_analysis_plural Resource
platform: aws
---

# aws_ec2_network_insights_analysis_plural

Use the `aws_ec2_network_insights_analysis_plural` InSpec audit resource to test properties of multiple AWS EC2 network insights analyses.

The `AWS::EC2::NetworkInsightsAnalysis` resource specifies a network insights analysis.

## Syntax

Ensure that network insights analysis ID exists.

    describe aws_ec2_network_insights_analysis_plural do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on AWS EC2 Network Insights Analysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| network_insights_analysis_ids | The ID of the network insights analysis. | network_insights_analysis_id |
| network_insights_analysis_arns | The Amazon Resource Name (ARN) of the network insights analysis. | network_insights_analysis_arn |
| network_insights_path_ids | The ID of the path. | network_insights_path_id |
| filter_in_arns | The Amazon Resource Names (ARN) of the Amazon Web Services resources that the path must traverse. | filter_in_arns |
| start_dates | The time the analysis started. | start_date |
| statuses | The status of the network insights analysis. | status |
| status_messages | The status message, if the status is failed. | status_message |
| network_path_found | Indicates whether the destination is reachable from the source. | network_path_found |
| forward_path_components | The components in the path from source to destination. | forward_path_components |
| return_path_components | The components in the path from destination to source. | return_path_components |
| explanations | The explanations. | explanations |
| alternate_path_hints | Potential intermediate components. | alternate_path_hints |
| tags | The tags of the insights analysis. | tags |

## Examples

### Ensure a network insights analysis ID is available.

    describe aws_ec2_network_insights_analysis_plural do
      its('network_insights_analysis_ids') { should include 'NETWORK_INSIGHTS_ANALYSIS_ID' }
    end

### Ensure that the network insights path ID is available.

    describe aws_ec2_network_insights_analysis_plural do
        its('network_insights_path_ids') { should include 'NETWORK_INSIGHTS_PATH_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_insights_analysis_plural do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_insights_analysis_plural do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInsightsAnalysesResult` action with `Effect` set to `Allow`.
