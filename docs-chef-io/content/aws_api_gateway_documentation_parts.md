+++
title = "aws_api_gateway_documentation_parts resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_documentation_parts"
identifier = "inspec/resources/aws/aws_api_gateway_documentation_parts resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_documentation_parts` InSpec audit resource to test properties of multiple documentation parts for an AWS API Gateway.

The `AWS::ApiGateway::DocumentationParts` resource creates a documentation part for an API.

For additional information, including details on parameters and properties, see the [AWS ApiGateway Documentation Part documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html).

## Syntax

Ensure that the documentation part exists.

```ruby
describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated REST API.

## Properties

`ids`
: The identifier for the documentation part resource.

`types`
: The type of API entity to which the documentation content applies.

`paths`
: The URL path of the target.

`methods`
: The HTTP verb of a method.

`status_codes`
: The HTTP status code of a response.

`names`
: The name of the targeted API entity.

`properties`
: A content map of API-specific key-value pairs describing the targeted API entity.

## Examples

**Ensure that the documentation part ID exists.**

```ruby
describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
  its('ids') { should include 'DOCUMENTATION_PART_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the documentation part is available.

```ruby
describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client::DocumentationParts" %}}
