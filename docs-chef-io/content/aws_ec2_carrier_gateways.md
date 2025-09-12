+++
title = "aws_ec2_carrier_gateways resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_carrier_gateways"
identifier = "inspec/resources/aws/aws_ec2_carrier_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_carrier_gateways` InSpec audit resource to test properties of the plural resource of AWS EC2 carrier gateway.

The AWS::EC2::CarrierGateway resource creates a carrier gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Carrier Gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html).

## Syntax

Ensure that the carrier gateway exists.

```ruby
describe aws_ec2_carrier_gateways do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`carrier_gateway_ids`
: The ID of the carrier gateway.

: **Field**: `carrier_gateway_id`

`vpc_ids`
: The ID of the VPC (Virtual Private Cloud) associated with the carrier gateway.

: **Field**: `vpc_id`

`states`
: The state of the carrier gateway.

: **Field**: `state`

`owner_ids`
: The Amazon Web Services account ID of the owner of the carrier gateway.

: **Field**: `owner_id`

`tags`
: The tags assigned to the carrier gateway.

: **Field**: `tags`

## Examples

Ensure a carrier gateway ID is available:

```ruby
describe aws_ec2_carrier_gateways do
  its('carrier_gateway_ids') { should include 'GATEWAY_ID' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_carrier_gateways do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_carrier_gateways do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_carrier_gateways do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCarrierGatewaysResult" %}}
