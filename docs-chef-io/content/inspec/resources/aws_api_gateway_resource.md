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

Use the `aws_api_gateway_resource` InSpec audit resource to test the properties of a single specific AWS API Gateway Resource.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway Resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-resource.html).

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
: The resource's identifier.

: **Field**: `id`

`parent_id`
: The parent resource's identifier.

: **Field**: `parent_id`

`path_part`
: The last path segment for this resource.

: **Field**: `path_part`

`path`
: The full path for this resource.

: **Field**: `path`

`resource_methods`
: Gets an API resource's method of a given HTTP verb.

: **Field**: `resource_methods`

## Examples

### Test to ensure a resource ID is available

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('id') { should eq 'RESOURCE_ID' }
end
```

### Test to ensure a resource path is available

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('path') { should eq '/' }
end
```

### Test to ensure a resource parent ID is available

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  its('parent_id') { should eq 'PARENT_ID' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:Resource" %}}
