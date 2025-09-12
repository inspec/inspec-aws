+++
title = "aws_ec2_carrier_gateway resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_carrier_gateway"
identifier = "inspec/resources/aws/aws_ec2_carrier_gateway resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_carrier_gateway` InSpec audit resource to test properties of a specific AWS EC2 carrier gateway.

The AWS::EC2::CarrierGateway resource creates a carrier gateway.

`carrier_gateway_id` _(required)_

 The ID of the carrier gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Carrier Gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html).

## Syntax

Ensure that the carrier gateway exists.

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
  it { should exist }
end
```

## Parameters

`carrier_gateway_id` _(required)_

 The ID of the carrier gateway.

## Properties

`carrier_gateway_id`
: The ID of the carrier gateway.

`vpc_id`
: The ID of the VPC (Virtual Private Cloud) associated with the carrier gateway.

`state`
: The state of the carrier gateway.

`owner_id`
: The Amazon Web Services account ID of the owner of the carrier gateway.

`tags`
: The tags assigned to the carrier gateway.

## Examples

**Ensure a carrier gateway ID is available.**

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
  its('carrier_gateway_id') { should eq 'GATEWAY_ID' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_carrier_gateway(carrier_gateway_id: "GATEWAY_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCarrierGatewaysResult" %}}
