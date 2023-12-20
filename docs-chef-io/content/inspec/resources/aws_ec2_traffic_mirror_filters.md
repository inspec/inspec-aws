+++
title = "aws_ec2_traffic_mirror_filters Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_traffic_mirror_filters"
identifier = "inspec/resources/aws/aws_ec2_traffic_mirror_filters Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_traffic_mirror_filters` InSpec audit resource to test properties of multiple AWS traffic mirror filters.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_ec2_traffic_mirror_filters` resource block declares the tests for a set of AWS traffic mirror filters.

```ruby
describe aws_ec2_traffic_mirror_filters do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`traffic_mirror_filter_ids`
: The ID of a traffic mirror filter.

`descriptions`
: The description of a traffic mirror filter.

`tags`
: A list of hashes with each key-value pair corresponding to an traffic mirror filter.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TrafficMirrorFilter.html)

## Examples

**Test that an EC2 traffic mirror filter exists.**

```ruby
describe aws_ec2_traffic_mirror_filters do
  it { should exist }
end
```

**Test that EC2 traffic mirror filter's description is correct.**

```ruby
describe aws_ec2_traffic_mirror_filters do
  its('descriptions') { should include 'DESCRIPTION_TEXT' }
end
```

**Test that an EC2 traffic mirror has the correct tag.**

```ruby
describe aws_ec2_traffic_mirror_filters do
  its('tags') { should include 'TAG' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that an entity exists.

```ruby
describe aws_ec2_traffic_mirror_filters do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_ec2_traffic_mirror_filters do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTrafficMirrorFiltersResult" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
