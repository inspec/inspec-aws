+++
title = "aws_api_gateway_v2_api_mappings resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_api_mappings"
identifier = "inspec/resources/aws/aws_api_gateway_v2_api_mappings resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_api_mappings` InSpec audit resource to test the properties of multiple AWS API Gateway V2 API mappings.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 ApiMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-apimapping.html).

## Syntax

Ensure the API mappings exist.

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_
: The domain name.

## Properties

`api_ids`
: The API identifier.

: **Field**: `api_id`

`api_mapping_ids`
: The API mapping identifier.

: **Field**: `api_mapping_id`

`api_mapping_keys`
: The API mapping key.

: **Field**: `api_mapping_key`

`stages`
: The API stage.

: **Field**: `stage`

## Examples

### Test to ensure an API ID is available

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  its('api_ids') { should include 'REST_API_ID' }
end
```

### Test to ensure an API mapping ID is available

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  its('api_mapping_ids') { should include 'API_MAPPING_ID' }
end
```

### Test to ensure an API mapping key is available

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  its('api_mapping_keys') { should include 'API_MAPPING_KEY' }
end
```

### Test to ensure an API mapping stage is available

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  its('stages') { should include 'API_STAGE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetApiMappingsResponse" %}}
