+++
title = "aws_ec2_network_insights_analysis Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_network_insights_analysis"
identifier = "inspec/resources/aws/aws_ec2_network_insights_analysis Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_insights_analysis` InSpec audit resource to test properties of a single specific AWS EC2 network insights analysis.

The `AWS::EC2::NetworkInsightsAnalysis` resource specifies a network insights analysis.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Network Insights Analysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that network insights analysis ID exists.

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
  it { should exist }
end
```

## Parameters

`network_insights_analysis_id` _(required)_

: The ID of the network insights analysis.

## Properties

`network_insights_analysis_id`
: The ID of the network insights analysis.

`network_insights_analysis_arn`
: The Amazon Resource Name (ARN) of the network insights analysis.

`network_insights_path_id`
: The ID of the path.

`filter_in_arns`
: The Amazon Resource Names (ARN) of the Amazon Web Services resources that the path must traverse.

`start_date`
: The time the analysis started.

`status`
: The status of the network insights analysis.

`status_message`
: The status message, if the status is failed.

`network_path_found`
: Indicates whether the destination is reachable from the source.

`forward_path_components`
: The components in the path from source to destination.

`return_path_components`
: The components in the path from destination to source.

`explanations`
: The explanations.

`alternate_path_hints`
: Potential intermediate components.

`tags`
: The tags of the insights analysis.

## Examples

**Ensure a Network Insights Analysis Id is available.**

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
  its('network_insights_analysis_id') { should eq 'NETWORK_INSIGHTS_ANALYSIS_ID' }
end
```

**Ensure that the Network Insights Path Id is available.**

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
    its('network_insights_path_id') { should eq 'NETWORK_INSIGHTS_PATH_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'NETWORK_INSIGHTS_ANALYSIS_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInsightsAnalysesResult" %}}
