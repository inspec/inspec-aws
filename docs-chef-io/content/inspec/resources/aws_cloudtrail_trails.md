+++
title = "aws_cloudtrail_trails Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudtrail_trails"
identifier = "inspec/resources/aws/aws_cloudtrail_trails Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudtrail_trails` InSpec audit resource to test properties of a collection of AWS CloudTrail Trails.

For additional information, including details on parameters and properties, see the [AWS documentation on Auto Scaling Group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_cloudtrail_trails` resource block returns all CloudTrail Trails and allows the testing of those trails.

```ruby
describe aws_cloudtrail_trails do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`trail_arns`
: Specifies the ARNs of the trails.

`names`
: The names of the trails.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a CloudTrail with a specific name exists.**

```ruby
describe aws_cloudtrail_trails do
  its('names') { should include('trail-1') }
end
```

**Ensure a CloudTrail with a specific arn exists.**

```ruby
describe aws_cloudtrail_trails do
  its('trail_arns') { should include('arn:aws:cloudtrail:us-east-1::trail/trail-1') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_cloudtrail_trails do
  it { should exist }
end
```

```ruby
describe aws_cloudtrail_trails do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudTrail:Client:DescribeTrailsResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awscloudtrail.html).
