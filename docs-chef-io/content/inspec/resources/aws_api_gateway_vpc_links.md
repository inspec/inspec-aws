+++
title = "aws_api_gateway_vpc_links resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_vpc_links"
identifier = "inspec/resources/aws/aws_api_gateway_vpc_links resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_vpc_links` InSpec audit resource to test multiple AWS API Gateway VPC link properties.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway VPCLink](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-vpclink.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that a VPC link exists.

```ruby
describe aws_api_gateway_vpc_links do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The identifier of the VPC link used to integrate to reference this VPC link.

: **Field**: `id`

`names`
: The name used to label and identify the VPC link.

: **Field**: `name`

`descriptions`
: The description of the VPC link.

: **Field**: `description`

`target_arns`
: The ARN of the network load balancer of the VPC targeted by the VPC link. The network load balancer must be owned by the same AWS account of the API owner.

: **Field**: `target_arns`

`statuses`
: The status of the VPC link. The valid values are `AVAILABLE`, `PENDING`, `DELETING`, or `FAILED`. If the status is `PENDING`, the API deployment waits, and if the status is `DELETING`, the API deployment fails.

: **Field**: `status`

`status_messages`
: A description about the VPC link status.

: **Field**: `status_message`

`tags`
: The collection of tags. Each tag element is associated with a given resource.

: **Field**: `tags`

## Examples

### Test to ensure a VPC link ID is available

```ruby
describe aws_api_gateway_vpc_links do
  its('ids') { should include 'VPC_LINK_ID' }
end
```

### Test to ensure a VPC link name is available

```ruby
describe aws_api_gateway_vpc_links do
  its('names') { should include 'VPC_LINK_NAME' }
end
```

### Test to verify the status as `AVAILABLE`

```ruby
describe aws_api_gateway_vpc_links do
  its('statuses') { should include 'AVAILABLE' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_vpc_links do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_vpc_links do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:VpcLinks" %}}
