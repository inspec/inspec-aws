+++
title = "aws_ec2_customer_gateway Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_customer_gateway"
identifier = "inspec/resources/aws/aws_ec2_customer_gateway Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_customer_gateway` InSpec audit resource to test properties of a single AWS EC2 customer gateway.

The `AWS::EC2::CustomerGateway` resource type specifies a customer gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 customer gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the customer gateway Id exists.

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
  it { should exist }
end
```

## Parameters

`customer_gateway_id` _(required)_

: The ID of the customer gateway.

## Properties

`bgp_asn`
: The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).

`customer_gateway_id`
: The ID of the customer gateway.

`ip_address`
: The internet-routable IP address of the customer gateway's outside interface.

`certificate_arn`
: The Amazon Resource Name (ARN) for the customer gateway certificate.

`state`
: The current state of the customer gateway.

`type`
: The type of VPN connection the customer gateway supports (ipsec.1).

`device_name`
: The name of customer gateway device.

`tags`
: Any tags assigned to the customer gateway.

## Examples

**Ensure a customer gateway ID is available.**

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
  its('customer_gateway_id') { should eq 'CUSTOMER_GATEWAY_ID' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeCustomerGatewaysResult" %}}
