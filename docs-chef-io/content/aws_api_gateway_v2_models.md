+++
title = "aws_api_gateway_v2_models resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_models"
identifier = "inspec/resources/aws/aws_api_gateway_v2_models resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_models` InSpec audit resource to test the properties of multiple AWS API Gateway V2 models.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Model](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-model.html).

## Syntax

Ensure that the model exists.

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

## Properties

`content_types`
: The content-type for the model, for example, **application/json**.

: **Field**: `content_type`

`descriptions`
: The description of the model.

: **Field**: `description`

`model_ids`
: The model identifier.

: **Field**: `model_id`

`names`
: The name of the model. Must be alphanumeric.

: **Field**: `name`

`schemas`
: The schema for the model. For application/json models, this should be JSON schema draft 4 model.

: **Field**: `schema`

## Examples

### Test to ensure a model ID is available

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  its('model_ids') { should include 'MODEL_ID' }
end
```

### Test to verify the model name

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  its('names') { should include 'MODEL_NAME' }
end
```

### Test to verify the model description

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  its('descriptions') { should include 'MODEL_DESCRIPTION' }
end
```

### Test to verify the model content type is 'application/json'

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  its('content_types') { should include 'application/json' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_models(api_id: 'APP_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetModelsResponse" %}}
