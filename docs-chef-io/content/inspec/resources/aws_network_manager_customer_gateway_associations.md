+++
title = "aws_network_manager_customer_gateway_associations Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_network_manager_customer_gateway_associations"
identifier = "inspec/resources/aws/aws_network_manager_customer_gateway_associations Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_manager_customer_gateway_associations` InSpec audit resource to test properties of multiple AWS Network Manager customer gateway associations.

The `AWS::NetworkManager::CustomerGatewayAssociation` resource specifies an association between a customer gateway, a device, and optionally, a link.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Manager Customer Gateway Association.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the customer gateway association exists.

```ruby
describe aws_network_manager_customer_gateway_associations(global_network_id: "GLOBAL_NETWORK_ID") do
  it { should exist }
end
```

## Parameters

`global_network_id` _(required)_

: The ID of the global network.

## Properties

`customer_gateway_arns`
: The Amazon Resource Name (ARN) of the customer gateway.

: **Field**: `customer_gateway_arn`

`global_network_ids`
: The ID of the global network.

: **Field**: `global_network_id`

`device_ids`
: The ID of the device.

: **Field**: `device_id`

`link_ids`
: The ID of the link.

: **Field**: `link_id`

`states`
: The association state.

: **Field**: `state`

## Examples

**Ensure a customer gateway arn is available.**

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
  its('customer_gateway_arns') { should include 'CustomerGatewayARN' }
end
```

**Ensure that the state is `active`.**

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
    its('states') { should include 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_manager_customer_gateway_association(global_network_id: "dummy") do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkManager:Client:GetCustomerGatewayAssociationsResponse" %}}
