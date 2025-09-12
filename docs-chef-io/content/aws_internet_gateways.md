+++
title = "aws_internet_gateways resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_internet_gateways"
identifier = "inspec/resources/aws/aws_internet_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_internet_gateways` InSpec audit resource to test the properties of all AWS internet gateways owned by the AWS account.

## Syntax

An `aws_internet_gateways` resource block collects all of the internet gateways and then tests that group.

```ruby
describe aws_internet_gateways do
  it { should exist }
end 
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The ID of the internet gateway.

: **Field**: `id`

`names`
: The value of the `Name` tag. It is `nil` if not defined.

: **Field**: `name`

`vpc_ids`
: The ID of the attached VPC. It is `nil` if the resource is in a `detached` state.

: **Field**: `vpc_id`

`tags`
: A hash, with each key-value pair corresponding to an internet gateway tag.

: **Field**: `tags`

`attachment_states`
: Indicates whether the internet gateway is attached to a VPC (`attached` or `detached`).

: **Field**: `attachment_state`

`owner_ids`
: The ID of the AWS account that owns the internet gateway.

: **Field**: `owner_id`

## Examples

**Test that there are exactly 3 internet gateways.**

```ruby
describe aws_internet_gateway do
  its('count') { should cmp 3 }
end
```

**Use this InSpec resource to request the ids of all internet gateways, then test in-depth using `aws_internet_gateway`.**

```ruby
aws_internet_gateways.ids.each do |id|
  describe aws_internet_gateway(id: id) do
    it { should be_attached }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.
The field names described in the [properties table](##-properties) should be used for the `<property>` in the `where` clause.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_internet_gateways.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe aws_internet_gateways.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeInternetGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
