+++
title = "aws_ec2_placement_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_placement_groups"
identifier = "inspec/resources/aws/aws_ec2_placement_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_placement_groups` InSpec audit resource to test properties of multiple AWS EC2 placement groups.

The `AWS::EC2::PlacementGroup` resource type specifies a placement group in which to launch instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 placement group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html).

## Syntax

Ensure that the placement group exists.

```ruby
describe aws_ec2_placement_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`group_names`
: The name of the placement group.

: **Field**: `group_name`

`states`
: The state of the placement group.

: **Field**: `state`

`strategies`
: The placement strategy.

: **Field**: `strategy`

`partition_counts`
: The number of partitions.

: **Field**: `partition_count`

`group_ids`
: The ID of the placement group.

: **Field**: `group_id`

`tags`
: Any tags applied to the placement group.

: **Field**: `tags`

## Examples

Ensure a placement group name is available:

```ruby
describe aws_ec2_placement_groups do
  its('group_names') { should include 'PLACEMENT_GROUP_NAME' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_placement_groups do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_placement_groups do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_ec2_placement_groups do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_placement_groups do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribePlacementGroupsResult" %}}
