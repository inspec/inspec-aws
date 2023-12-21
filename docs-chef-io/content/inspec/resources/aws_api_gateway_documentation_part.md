+++
title = "aws_api_gateway_documentation_part Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_documentation_part"
identifier = "inspec/resources/aws/aws_api_gateway_documentation_part Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_documentation_part` InSpec audit resource to test properties of a single documentation part for an AWS API Gateway.

The `AWS::ApiGateway::DocumentationPart` resource creates a documentation part for an API.

For additional information, including details on parameters and properties, see the [AWS ApiGateway Documentation Part](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the documentation part exists.

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated REST API.

`documentation_part_id` _(required)_

: The identifier of the documentation part resource to get information about.

## Properties

`id`
: The identifier for the documentation part resource.

`location.type`
: The type of API entity to which the documentation content applies.

`location.path`
: The URL path of the target.

`location.method`
: The HTTP verb of a method.

`location.status_code`
: The HTTP status code of a response.

`location.name`
: The name of the targeted API entity.

`properties`
: A content map of API-specific key-value pairs describing the targeted API entity.

## Examples

**Ensure that the documentation part ID exists.**

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
  its('id') { should eq 'DOCUMENTATION_PART_ID' }
end
```

**Check whether the API path exists for a documentation part.**

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
    its('location.path') { should eq 'REQUEST_BODY' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:DocumentationPart" %}}
