+++
title = "aws_network_manager_customer_gateway_association resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_manager_customer_gateway_association"
identifier = "inspec/resources/aws/aws_network_manager_customer_gateway_association resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_manager_customer_gateway_association` InSpec audit resource to test properties of a single specific AWS Network Manager customer gateway association.

The `AWS::NetworkManager::CustomerGatewayAssociation` resource specifies an association between a customer gateway, a device, and optionally, a link.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Manager Customer Gateway Association.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html).

## Syntax

Ensure that the customer gateway association exists.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
  it { should exist }
end
```

## Parameters

`global_network_id` _(required)_

: The ID of the global network.

`customer_gateway_arn` _(required)_

: The Amazon Resource Name (ARN) of the customer gateway.

## Properties

`customer_gateway_arn`
: The Amazon Resource Name (ARN) of the customer gateway.

`global_network_id`
: The ID of the global network.

`device_id`
: The ID of the device.

`link_id`
: The ID of the link.

`state`
: The association state.

## Examples

**Ensure a customer gateway arn is available.**

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
  its('customer_gateway_arn') { should eq 'CustomerGatewayARN' }
end
```

**Ensure that the state is `active`.**

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
    its('state') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkManager:Client:GetCustomerGatewayAssociationsResponse" %}}
