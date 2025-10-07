+++
title = "aws_ec2_customer_gateways resource"

draft = false


[menu.aws]
title = "aws_ec2_customer_gateways"
identifier = "inspec/resources/aws/aws_ec2_customer_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_customer_gateways` InSpec audit resource to test properties of the plural resource of AWS EC2 customer gateway.

The `AWS::EC2::CustomerGateway` resource type specifies a customer gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 customer gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html).

## Syntax

Ensure that the customer gateway exists.

```ruby
describe aws_ec2_customer_gateways do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`bgp_asns`
: The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).

: **Field**: `bgp_asn`

`customer_gateway_ids`
: The ID of the customer gateway.

: **Field**: `customer_gateway_id`

`ip_addresses`
: The Internet-routable IP address of the customer gateway's outside interface.

: **Field**: `ip_address`

`certificate_arns`
: The Amazon Resource Name (ARN) for the customer gateway certificate.

: **Field**: `certificate_arn`

`states`
: The current state of the customer gateway.

: **Field**: `state`

`types`
: The type of VPN connection the customer gateway supports (ipsec.1).

: **Field**: `type`

`device_names`
: The name of customer gateway device.

: **Field**: `device_name`

`tags`
: Any tags assigned to the customer gateway.

: **Field**: `tags`

## Examples

Ensure a customer gateway ID is available:

```ruby
describe aws_ec2_customer_gateways do
  its('customer_gateway_ids') { should include 'CUSTOMER_GATEWAY_ID' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_customer_gateways do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_customer_gateways do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_customer_gateways do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_customer_gateways do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCustomerGatewaysResult" %}}
