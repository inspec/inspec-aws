+++
title = "aws_ec2_traffic_mirror_filter resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_traffic_mirror_filter"
identifier = "inspec/resources/aws/aws_ec2_traffic_mirror_filter resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_traffic_mirror_filter` InSpec audit resource to test properties of a single AWS traffic mirror filter.

## Syntax

An `aws_ec2_traffic_mirror_filter` resource block declares the tests for a single AWS traffic mirror filter.

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  it { should exist }
end
```

```ruby
describe aws_ec2_traffic_mirror_filter('TRAFFIC_MIRROR_FILTER_ID') do
  it { should exist }
end
```

## Parameters

`traffic_mirror_filter_id` _(required)_

: The ID of the EC2 traffic mirror. This is in the format of `tmf-` followed by 8 or 17 hexadecimal characters.
  This can be passed either as a string or as an `aws_ec2_traffic_mirror_filter_id: 'value'` key-value entry in a hash.

## Properties

`traffic_mirror_filter_id`
: The ID of a traffic mirror filter.

`description`
: The description of a traffic mirror filter.

`tags`
: A list of hashes with each key-value pair corresponding to a traffic mirror tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TrafficMirrorFilter.html)

## Examples

Test that an EC2 traffic mirror should exist:

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  it { should exist }
end
```

Test that an EC2 traffic mirror description is correct:

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  its('description') { should eq "DESCRIPTION_TEXT" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  it { should_not exist }
end
```

### be_available

Check if the test the entity is available.

```ruby
describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTrafficMirrorFiltersResult" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
