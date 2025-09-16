+++
title = "aws_ec2_network_insights_paths resource"

draft = false


[menu.aws]
title = "aws_ec2_network_insights_paths"
identifier = "inspec/resources/aws/aws_ec2_network_insights_paths resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_insights_paths` InSpec audit resource to test properties of multiple AWS EC2 paths to analyze for reachability.

The `AWS::EC2::NetworkInsightsPath` resource specifies a path to analyze for reachability.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 network insights path](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html).

## Syntax

Ensure that network insights path ID exists.

```ruby
describe aws_ec2_network_insights_paths do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`network_insights_path_ids`
: The ID of the path.

: **Field**: `network_insights_path_id`

`network_insights_path_arns`
: The Amazon Resource Name (ARN) of the path.

: **Field**: `network_insights_path_arn`

`created_dates`
: The time stamp when the path was created.

: **Field**: `created_date`

`sources`
: The Amazon Web Services resource that is the source of the path.

: **Field**: `source`

`destinations`
: The Amazon Web Services resource that is the destination of the path.

: **Field**: `destination`

`source_ips`
: The IP address of the Amazon Web Services resource that is the source of the path.

: **Field**: `source_ip`

`destination_ips`
: The IP address of the Amazon Web Services resource that is the destination of the path.

: **Field**: `destination_ip`

`protocols`
: The protocol.

: **Field**: `protocol`

`destination_ports`
: The destination port.

: **Field**: `destination_port`

`tags`
: The tags associated with the path.

: **Field**: `tags`

## Examples

Ensure a network insights path ID is available:

```ruby
describe aws_ec2_network_insights_paths do
  its('network_insights_path_ids') { should include 'NETWORK_INSIGHTS_PATH_ID' }
end
```

Ensure a network insights path ARN is available:

```ruby
describe aws_ec2_network_insights_paths do
    its('network_insights_path_arns') { should include 'NETWORK_INSIGHTS_PATH_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_insights_paths do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_insights_paths do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInsightsPathsResult" %}}
