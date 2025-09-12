+++
title = "aws_ec2_prefix_list resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_prefix_list"
identifier = "inspec/resources/aws/aws_ec2_prefix_list resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_prefix_list` InSpec audit resource to test properties of a single specific AWS EC2 prefix list.

The `AWS::EC2::PrefixList` resource specifies a managed prefix list.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 prefix lists](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist.html).

## Syntax

Ensure that a prefix list exists.

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  it { should exist }
end
```

## Parameters

`prefix_list_id` _(required)_

: The ID of the prefix list.

## Properties

`prefix_list_id`
: The ID of the prefix list.

`address_family`
: The IP address version.

`state`
: The state of the prefix list.

`state_message`
: The state message.

`prefix_list_arn`
: The Amazon Resource Name (ARN) for the prefix list.

`prefix_list_name`
: The name of the prefix list.

`max_entries`
: The maximum number of entries for the prefix list.

`version`
: The version of the prefix list.

`tags`
: The tags for the prefix list.

`owner_id`
: The ID of the owner of the prefix list.

## Examples

Ensure a prefix list ID is available:

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  its('prefix_list_id') { should eq 'PREFIX_LIST_ID' }
end
```

Ensure an address family is available:

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  its('address_family') { should eq 'ADDRESS_FAMILY' }
end
```

Ensure that the state is `AVAILABLE`:

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
    its('state') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_prefix_list(prefix_list_id: 'PREFIX_LIST_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeManagedPrefixListsResult" %}}
