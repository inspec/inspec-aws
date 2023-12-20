+++
title = "aws_api_gateway_models Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_models"
identifier = "inspec/resources/aws/aws_api_gateway_models Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_models` Chef InSpec audit resource to test properties of the plural resource of AWS API Gateway model.

The `AWS::ApiGateway::Model` resource defines the structure of a request or response payload for an API method.

For additional information, including details on parameters and properties, see the [AWS documentation on `AWS::APIGateway::Model` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-model.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the model exists.

```ruby
describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The ID of a REST API associated with this model.

## Properties

`ids`
: The identifier for the model resource.

: **Field**: `id`

`names`
: The name of the model. Must be an alphanumeric string.

: **Field**: `name`

`descriptions`
: The description of the model.

: **Field**: `description`

`schemas`
: The schema for the model. For `application/json` models, this should be [JSON schema draft 4](https://tools.ietf.org/html/draft-zyp-json-schema-04) model.

: **Field**: `schema`

`content_types`
: The content-type for the model.

: **Field**: `content_type`

## Examples

**Ensure an ID is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('ids') { should include 'MODEL_ID' }
end
```

**Ensure a name is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('names') { should include 'MODEL_NAME' }
end
```

**Ensure a description is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('descriptions') { should include 'MODEL_DESCRIPTION' }
end
```

**Ensure a content type is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('content_types') { should include 'CONTENT_TYPE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApiGateway:Client:Models" %}}
