+++
title = "aws_api_gateway_v2_api_mapping resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_api_mapping"
identifier = "inspec/resources/aws/aws_api_gateway_v2_api_mapping resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_api_mapping` InSpec audit resource to test the properties of a specific AWS API Gateway V2 API mapping.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 ApiMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-apimapping.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that an API mapping exists.

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`api_mapping_id` _(required)_
: The API mapping identifier.

`domain_name` _(required)_
: The domain name.

## Properties

`api_id`
: The API identifier.

`api_mapping_id`
: The API mapping identifier.

`api_mapping_key`
: The API mapping key.

`stage`
: The API stage.

## Examples

### Test to ensure an API ID is available

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  its('api_id') { should eq 'REST_API_ID' }
end
```

### Test to ensure an API mapping ID is available

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  its('api_mapping_id') { should eq 'API_MAPPING_ID' }
end
```

### Test to ensure an API mapping key is available

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  its('api_mapping_key') { should eq 'API_MAPPING_KEY' }
end
```

### Test to ensure an API mapping stage is available

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  its('stage') { should eq 'API_STAGE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetApiMappingResponse" %}}
