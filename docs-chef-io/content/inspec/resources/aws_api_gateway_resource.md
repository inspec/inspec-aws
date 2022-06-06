+++
title = "aws_api_gateway_resource resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_resource"
identifier = "inspec/resources/aws/aws_api_gateway_resource resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_resource` InSpec audit resource to test the properties of a single specific AWS APIGateway Resource.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway Resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-resource.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the resource exists.

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi.

`resource_id` _(required)_

: The identifier for the Resource resource.

## Properties

`id`
: rest_api_idrest_api_idrest_api_idrest_api_idrest_api_idrest_api_idrest_api_idrest_api_id

: **Field**: `id`

## Examples

**Ensure an usage plan id is available.**

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('id') { should eq 'USAGE_PLAN_ID' }
end
```

**Ensure an usage plan name is available.**

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('name') { should eq 'USAGE_PLAN_NAME' }
end
```

**Verify the quota limit is set to `2` in the usage plan api gateway.**

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('quota.limit') { should eq 2 }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:Resource" %}}
