+++
title = "aws_api_gateway_vpc_link resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_vpc_link"
identifier = "inspec/resources/aws/aws_api_gateway_vpc_link resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_vpc_link` InSpec audit resource to test the properties of a single specific AWS APIGateway VPCLink.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway VPCLink](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-vpclink.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that an VPC link exists.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should exist }
end
```

## Parameters

`vpc_link_id` _(required)_

: The identifier of the VpcLink.

## Properties

`id`
: The identifier of the VpcLink. It is used in an Integration to reference this VpcLink.

`name`
: The name used to label and identify the VPC link.

`description`
: The description of the VPC link.

`target_arns`
: The ARN of the network load balancer of the VPC targeted by the VPC link. The network load balancer must be owned by the same AWS account of the API owner.

`status`
: The status of the VPC link. The valid values are AVAILABLE , PENDING , DELETING , or FAILED . Deploying an API will wait if the status is PENDING and will fail if the status is DELETING .

`status_message`
: A description about the VPC link status.

`tags`
: The collection of tags. Each tag element is associated with a given resource.

## Examples

**Ensure an VPC link id is available.**

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('id') { should eq 'VPC_LINK_ID' }
end
```

**Ensure an VPC Link name is available.**

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('name') { should eq 'VPC_LINK_NAME' }
end
```

**Verify the status is `AVAILABLE`.**

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('status') { should eq 'AVAILABLE' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:VpcLink" %}}
