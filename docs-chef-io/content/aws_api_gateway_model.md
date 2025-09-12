+++
title = "aws_api_gateway_model resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_model"
identifier = "inspec/resources/aws/aws_api_gateway_model resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_model` Chef InSpec audit resource to test properties of a single AWS API Gateway model.

The `AWS::ApiGateway::Model` resource defines the structure of a request or response payload for an API method.

For additional information, including details on parameters and properties, see the [AWS documentation on `AWS::APIGateway::Model` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-model.html).

## Syntax

Ensure that the model exists.

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The ID of a REST API associated with this model.

`model_name` _(required)_

: A name for the model.

## Properties

`id`
: The identifier for the model resource.

`name`
: The name of the model. Must be an alphanumeric string.

`description`
: The description of the model.

`schema`
: The schema for the model. For `application/json` models, this should be [JSON schema draft 4](https://tools.ietf.org/html/draft-zyp-json-schema-04) model.

`content_type`
: The content-type for the model.

## Examples

**Ensure an ID is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('id') { should eq 'MODEL_ID' }
end
```

**Ensure a name is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('name') { should eq 'MODEL_NAME' }
end
```

**Ensure a description is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('description') { should eq 'MODEL_DESCRIPTION' }
end
```

**Ensure a content type is available.**

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  its('content_type') { should eq 'CONTENT_TYPE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApiGateway:Client:Model" %}}
