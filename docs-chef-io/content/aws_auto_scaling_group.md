+++
title = "aws_auto_scaling_group resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_auto_scaling_group"
identifier = "inspec/resources/aws/aws_auto_scaling_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_auto_scaling_group` InSpec audit resource to test properties of a single AWS Auto Scaling group.

For additional information, including details on parameters and properties, see the [AWS documentation on Auto Scaling Group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html).

## Syntax

Ensure that an auto scaling group exists and has the correct scale sizes

```ruby
describe aws_auto_scaling_group('MyAutoScalingGroup') do
  it              { should exist }
  its('min_size') { should be 1}
  its('max_size') { should be 4}
end  
```

You may also use hash syntax to pass the auto scaling group name

```ruby
describe aws_auto_scaling_group(name: 'MyAutoScalingGroup') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: This resource accepts a single parameter, the Auto Scaling Group Name which uniquely identifies the auto scaling group.
  This can be passed either as a string or as a `name: 'value'` key-value entry in a hash.

## Properties

`min_size`
: An integer indicating the minimum number of instances in the auto scaling group.

`maximum_size`
: An integer indicating the maximum number of instances in the auto scaling group.

`desired_capacity`
: An integer indicating the desired  number of instances in the auto scaling group.

`launch_configuration_name`
: The name of the auto scaling launch configuration associated with the auto scaling group.

`vpc_zone_identifier`
: An array of strings corresponding to the subnet IDs associated with the auto scaling group.

`tags`
: An hash with each key-value pair corresponding to a tag associated with the entity.

## Examples

**Ensure that an auto scaling group has the correct desired capacity.**

```ruby
describe aws_auto_scaling_group('MyAutoScalingGroup') do
  it                      { should exist }
  its('desired_capacity') { should be 2 }
end  
```

**Ensure that an auto scaling group has the correct Launch Configuration name and VPC identifier.**

```ruby
describe aws_auto_scaling_group('MyAutoScalingGroup') do
  it                               { should exist }
  its('launch_configuration_name') { should eq 'MyLaunchConfiguration'}
  its('vpc_zone_identifier')       { should include 'subnet-1234'}
end  
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_auto_scaling_group('AnExistingASG') do
  it { should exist }
end
```

```ruby
describe aws_auto_scaling_group('ANonExistentASG') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="AutoScaling:Client:AutoScalingGroupsType" %}}
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/control-access-using-iam.html).
