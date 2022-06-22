+++
title = "aws_api_gateway_resources Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_resources"
identifier = "inspec/resources/aws/aws_api_gateway_resources Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_resources` Chef InSpec audit resource to test the properties of multiple AWS API Gateway Resources.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway Resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-resource.html).

## Syntax

Ensure that the resource exists.

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi.

## Properties

`ids`
: The resource's identifier.

: **Field**: `id`

`parent_ids`
: The parent resource's identifier.

: **Field**: `parent_id`

`path_parts`
: The last path segment for this resource.

: **Field**: `path_part`

`paths`
: The full path for this resource.

: **Field**: `path`

`resource_methods`
: Gets an API resource's method of a given HTTP verb.

: **Field**: `resource_methods`

## Examples

### Test to ensure the resource is present

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
  its('ids') { should include 'RESOURCE_ID' }
end
```

### Test to ensure the parent ID is present

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
  its('parent_ids') { should include 'PARENT_ID' }
end
```

### Test to ensure the path includes `/`

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
    its('paths') { should include "/" }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_resources(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:Resources" %}}
