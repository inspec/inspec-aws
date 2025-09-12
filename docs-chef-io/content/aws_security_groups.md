+++
title = "aws_security_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_security_groups"
identifier = "inspec/resources/aws/aws_security_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_security_groups` InSpec audit resource to test properties of some or all security groups.

Security groups are a networking construct that contain ingress and egress rules for network communications. Security groups may be attached to EC2 instances, as well as certain other AWS resources. Along with Network Access Control Lists, Security Groups are one of the two main mechanisms of enforcing network-level security.

For additional information, including details on parameters and properties, see the [AWS documentation on Security Groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html).

## Syntax

An `aws_security_groups` resource block uses an optional filter to select a group of security groups and then tests that group.

```ruby
describe aws_security_groups do
  its('entries.count') { should be > 1 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`group_ids`
: The name of the auto scaling launch configuration associated with the auto scaling group.

`group_names`
: An integer indicating the maximum number of instances in the auto scaling group.

`vpc_ids`
: An integer indicating the desired  number of instances in the auto scaling group.

`ip_permissions`
: A list of the rules that the Security Group applies to incoming network traffic.

`ip_permissions_egress`
: A list of the rules that the Security Group applies to outgoing network traffic initiated by the AWS resource in the Security Group.

`descriptions`
: Description for the rule, which can help to identify it later. A description can be up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*.

`tags`
: An integer indicating the minimum number of instances in the auto scaling group.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

The following examples show how to use this InSpec audit resource.

**Look for a particular security group in just one VPC.**

```ruby
describe aws_security_groups.where( vpc_id: 'vpc-12345678') do
  its('group_ids') { should include('sg-abcdef12')}
end
```

**Examine the default security group in all VPCs.**

```ruby
describe aws_security_groups.where( group_name: 'default') do
  it { should exist }
end
```

**Allow at most 100 security groups on the account.**

```ruby
describe aws_security_groups do
  its('entries.count') { should be <= 100}
end
```

**Pass entry resource data from security groups to the singular resource for testing.**

Use the `security_group_objects` resource to pass resource data to the singular resource for testing.
This method uses local in-memory caching for quicker execution of large sets of test cases.

```ruby
aws_security_groups.entries.each do |entry|
    describe aws_security_group(resource_data: entry) do
        it { should exist }
        its('count') { should be >= 4 }
    end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the filter returns at least one result.

Use `should_not` if you expect zero matches.

    # You will always have at least one SG, the VPC default SG

```ruby
describe aws_security_groups
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeSecurityGroupsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
