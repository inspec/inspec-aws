+++
title = "aws_ec2_network_insights_analysis_plural Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_network_insights_analysis_plural"
identifier = "inspec/resources/aws/aws_ec2_network_insights_analysis_plural Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_insights_analysis_plural` InSpec audit resource to test properties of multiple AWS EC2 network insights analyses.

The `AWS::EC2::NetworkInsightsAnalysis` resource specifies a network insights analysis.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Network Insights Analysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that network insights analysis ID exists.

```ruby
describe aws_ec2_network_insights_analysis_plural do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`network_insights_analysis_ids`
: The ID of the network insights analysis.

: **Field**: `network_insights_analysis_id`

`network_insights_analysis_arns`
: The Amazon Resource Name (ARN) of the network insights analysis.

: **Field**: `network_insights_analysis_arn`

`network_insights_path_ids`
: The ID of the path.

: **Field**: `network_insights_path_id`

`filter_in_arns`
: The Amazon Resource Names (ARN) of the Amazon Web Services resources that the path must traverse.

: **Field**: `filter_in_arns`

`start_dates`
: The time the analysis started.

: **Field**: `start_date`

`statuses`
: The status of the network insights analysis.

: **Field**: `status`

`status_messages`
: The status message, if the status is failed.

: **Field**: `status_message`

`network_path_found`
: Indicates whether the destination is reachable from the source.

: **Field**: `network_path_found`

`forward_path_components`
: The components in the path from source to destination.

: **Field**: `forward_path_components`

`return_path_components`
: The components in the path from destination to source.

: **Field**: `return_path_components`

`explanations`
: The explanations.

: **Field**: `explanations`

`alternate_path_hints`
: Potential intermediate components.

: **Field**: `alternate_path_hints`

`tags`
: The tags of the insights analysis.

: **Field**: `tags`

## Examples

**Ensure a network insights analysis ID is available.**

```ruby
describe aws_ec2_network_insights_analysis_plural do
  its('network_insights_analysis_ids') { should include 'NETWORK_INSIGHTS_ANALYSIS_ID' }
end
```

**Ensure that the network insights path ID is available.**

```ruby
describe aws_ec2_network_insights_analysis_plural do
    its('network_insights_path_ids') { should include 'NETWORK_INSIGHTS_PATH_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_insights_analysis_plural do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_insights_analysis_plural do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInsightsAnalysesResult" %}}
