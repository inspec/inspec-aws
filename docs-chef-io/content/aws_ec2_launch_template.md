+++
title = "aws_ec2_launch_template resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_launch_template"
identifier = "inspec/resources/aws/aws_ec2_launch_template resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_launch_template` InSpec audit resource to test properties of a single AWS Launch Template.

## Syntax

An `aws_ec2_launch_template` resource block declares the tests for a single  AWS Launch Template by either launch_template_name or launch_template_id.

```ruby
describe aws_ec2_launch_template(launch_template_id: 'lt-01a2349e94458a507') do
  it { should exist }
end
```

```ruby
describe aws_ec2_launch_template(launch_template_name: 'my-template') do
  it { should exist }
end
```

## Parameters

One of either the launch_template_name or launch_template_id must be be provided.

`launch_template_id`

: The ID of the EC2 launch_template. This is in the format of `lt-` followed by 8 or 17 hexadecimal characters.
  This can be passed either as a string or as an `launch_template_id: 'value'` key-value entry in a hash.

## Properties

`launch_template_name`
: The name of launch template.

`launch_template_id`
: The id of the launch template.

`create_time`
: The create time of the launch resource.

`created_by`
: The time the instance was launched.

`default_version_number`
: The availability zone of the instance.

`latest_version_number`
: A hash containing the security group ids and names associated with the instance.

`tags`
: A list of hashes with each key-value pair corresponding to an EC2 instance tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

**Test that an launch template should exist.**

```ruby
describe aws_ec2_launch_template(launch_template_id: 'lt-01a2349e94458a507') do
  it { should exist }
end
```

**Test that an EC2 instance is using the correct AMI.**

```ruby
describe aws_ec2_launch_template(launch_template_id: 'lt-01a2349e94458a507') do
  its('default_version_number') { should eq 1 }
end
```

**Test that an EC2 instance has the correct tag.**

```ruby
describe aws_ec2_launch_template(launch_template_id: 'lt-01a2349e94458a507') do
  its('launch_template_name') { should eq 'test-lt' }
end
```
