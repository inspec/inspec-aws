+++
title = "aws_ec2_placement_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_placement_group"
identifier = "inspec/resources/aws/aws_ec2_placement_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_placement_group` InSpec audit resource to test properties of a single specific AWS EC2 placement group.

The `AWS::EC2::PlacementGroup` resource type specifies a placement group in which to launch instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 placement group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the placement group exists.

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
  it { should exist }
end
```

## Parameters

`placement_group_name` _(required)_

: The name of the placement group.

## Properties

`group_name`
: The name of the placement group.

`state`
: The state of the placement group.

`strategy`
: The placement strategy.

`partition_count`
: The number of partitions.

`group_id`
: The ID of the placement group.

`tags`
: Any tags applied to the placement group.

## Examples

**Ensure a placement group name is available.**

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
  its('group_name') { should eq 'PLACEMENT_GROUP_NAME' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribePlacementGroupsResult" %}}
