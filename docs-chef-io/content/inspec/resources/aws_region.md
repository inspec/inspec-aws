+++
title = "aws_region Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_region"
identifier = "inspec/resources/aws/aws_region Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_region` InSpec audit resource to test properties of a single AWS region.

For additional information, including details on parameters and properties, see the [AWS documentation on Regions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_region` resource block identifies an AWS region by ID. If no region is provided, the current default is used.

```ruby
describe aws_region('eu-west-2') do
  it { should exist }
end
```

```ruby
describe aws_region(region_name: 'us-east-1') do
  it { should exist }
  its('opt_in_status') { should cmp 'opt-in-not-required' }
end
```

## Parameters

`region_name` _(optional)_

: This resource accepts a single parameter, the region_name. 
  This can be passed either as a string or as a `region_name: 'value'` key-value entry in a hash.

## Properties

`region_name`
: The Name of the region.

`endpoint`
: The resolved endpoint of the region.

`opt_in_status`
: The opt-in status of the Region (opt-in-not-required | opted-in | not-opted-in).

## Examples

**Test whether a region exists.**

```ruby
describe aws_region('region-not-real') do
  it { should_not exist }
end
```

**Test the Region Endpoint.**

```ruby
describe aws_region(region_name: 'eu-west-2') do
  its('endpoint') { should eq 'ec2.eu-west-2.amazonaws.com' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

The control will pass if the describe returns at least one result.

```ruby
it { should exist }
```

### ebs_encryption_enabled

The control will pass if the region has EBS volume encryption enabled by default.

```ruby
it { should have_ebs_encryption_enabled }
```

## AWS Permissions

{{% aws_permissions_principal action="EC2:Client:DescribeRegionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
