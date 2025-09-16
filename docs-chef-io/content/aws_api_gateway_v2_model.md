+++
title = "aws_api_gateway_v2_model resource"

draft = false


[menu.aws]
title = "aws_api_gateway_v2_model"
identifier = "inspec/resources/aws/aws_api_gateway_v2_model resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_model` InSpec audit resource to test the properties of a specific AWS API Gateway V2 model.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Model](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-model.html).

## Syntax

Ensure that the model exists.

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

`model_id` _(required)_
: The model identifier.

## Properties

`content_type`
: The content-type for the model, for example, **application/json**.

`description`
: The description of the model.

`model_id`
: The model identifier.

`name`
: The name of the model. Must be alphanumeric.

`schema`
: The schema for the model. For application/json models, this should be JSON schema draft 4 model.

## Examples

### Test to ensure a model ID is available

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  its('model_id') { should eq 'MODEL_ID' }
end
```

### Test to verify the model name

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  its('name') { should eq 'MODEL_NAME' }
end
```

### Test to verify the model description

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  its('description') { should eq 'MODEL_DESCRIPTION' }
end
```

### Test to verify the model content type

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  its('content_type') { should eq 'application/json' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetModelResponse" %}}
