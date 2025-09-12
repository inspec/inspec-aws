+++
title = "aws_api_gateway_vpc_link resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_vpc_link"
identifier = "inspec/resources/aws/aws_api_gateway_vpc_link resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_vpc_link` InSpec audit resource to test the properties of a single specific AWS API Gateway VPC link.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway VPCLink](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-vpclink.html).

## Syntax

Ensure that a VPC link exists.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should exist }
end
```

## Parameters

`vpc_link_id` _(required)_

: The identifier of the VPC link.

## Properties

`id`
: The identifier of the VPC link used to integrate to reference this VPC link.

`name`
: The name used to label and identify the VPC link.

`description`
: The description of the VPC link.

`target_arns`
: The ARN of the network load balancer of the VPC targeted by the VPC link. The network load balancer must be owned by the same AWS account of the API owner.

`status`
: The status of the VPC link. The valid values are `AVAILABLE`, `PENDING`, `DELETING`, or `FAILED`. If the status is `PENDING`, the API deployment waits, and if the status is `DELETING`, the API deployment fails.

`status_message`
: A description about the VPC link status.

`tags`
: The collection of strings. Each tag element is associated with a given resource.

## Examples

### Test to ensure a VPC link ID is available

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('id') { should eq 'VPC_LINK_ID' }
end
```

### Test to ensure a VPC link name is available

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('name') { should eq 'VPC_LINK_NAME' }
end
```

### Test to verify the status as `AVAILABLE`

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  its('status') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:VpcLink" %}}
