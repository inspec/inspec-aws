+++
title = "aws_apigateway_api_key resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_apigateway_api_key"
identifier = "inspec/resources/aws/aws_apigateway_api_key resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_api_key` InSpec audit resource to test properties of a single specific AWS APIGateway ApiKey.

The AWS::ApiGateway::ApiKey resource creates a unique key that you can distribute to clients who are executing API Gateway Method resources that require an API key.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway ApiKey.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html).

## Syntax

Ensure that the api key exists.

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
  it { should exist }
end
```

## Parameters

`api_key` _(required)_

: The identifier of the API key resource.

## Properties

`id`
: The identifier of the API Key.

`value`
: The value of the API Key.

`name`
: The name of the API Key.

`customer_id`
: An AWS Marketplace customer identifier , when integrating with the AWS SaaS Marketplace.

`description`
: The description of the API Key.

`enabled`
: Specifies whether the API Key can be used by callers.

`created_date`
: The timestamp when the API Key was created.

`last_updated_date`
: The timestamp when the API Key was last updated.

`stage_keys`
: A list of Stage resources that are associated with the API key resource.

`tags`
: The collection of tags. Each tag element is associated with a given resource.

## Examples

**Ensure an ID is available.**

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
  its('id') { should eq 'ID' }
end
```

**Ensure that the name is available.**

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
    its('name') { should eq 'API_KEY_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:ApiKey" %}}
