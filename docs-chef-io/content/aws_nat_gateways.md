+++
title = "aws_nat_gateways resource"

draft = false


[menu.aws]
title = "aws_nat_gateways"
identifier = "inspec/resources/aws/aws_nat_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_nat_gateways` InSpec audit resource to test the properties of all AWS NAT gateways owned by the AWS account.

## Syntax

An `aws_nat_gateways` resource block collects all of the NAT gateways and then tests that group.

```ruby
describe aws_nat_gateways do
  it { should exist }
end 
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The ID of the NAT gateway.

: **Field**: `id`

`names`
: The value of the `Name` tag. It is `nil` if not defined.

: **Field**: `name`

`vpc_ids`
: The ID of the VPC in which the NAT gateway is located.

: **Field**: `vpc_id`

`subnet_ids`
: The ID of the subnet in which the NAT gateway is placed.

: **Field**: `subnet_id`

`tags`
: A hash, with each key-value pair corresponding to a NAT gateway tag.

: **Field**: `tags`

`states`
: The sate of the NAT gateway. Valid values are: `pending`, `failed`, `available`, `deleting` and `deleted`.

: **Field**: `state`

## Examples

Test that there are exactly 3 NAT gateways:

```ruby
describe aws_nat_gateways do
  its('count') { should cmp 3 }
end
```

Use this InSpec resource to request the ids of all NAT gateways, then test in-depth using `aws_nat_gateway` InSpec singular AWS resource:

```ruby
aws_nat_gateways.ids.each do |id|
  describe aws_nat_gateway(id: id) do
    its('state') { should eq 'available' }
  end
end
```

For more examples, see the [integration tests](https://github.com/inspec/inspec-aws/blob/main/test/integration/verify/controls/aws_nat_gateways.rb).

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.
The field names described in the [properties](#properties) should be used for the `<property>` in the `where` clause.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_nat_gateways.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe aws_nat_gateways.where( <property>: <value>) do
  it { should_not exist }
end
```

Please see [here](https://github.com/inspec/inspec/blob/master/docs/dev/filtertable-usage.md) for more information on how to use filter table.

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNatGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
