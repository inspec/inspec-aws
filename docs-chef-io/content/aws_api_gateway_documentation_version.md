+++
title = "aws_api_gateway_documentation_version resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_documentation_version"
identifier = "inspec/resources/aws/aws_api_gateway_documentation_version resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_documentation_version` InSpec audit resource to test properties of a single AWS API Gateway documentation version.

The `AWS::ApiGateway::DocumentationVersion` resource creates a documentation version for an API.

For additional information, including details on parameters and properties, see the [AWS ApiGateway documentation version documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html).

## Syntax

Ensure that the documentation version exists.

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi.

`documentation_version` _(required)_

: The identifier of the documentation version resource to get information about.

## Properties

`created_date`
: The date when the API documentation snapshot is created.

`version`
: The version identifier of the API documentation snapshot.

`description`
: The description of the API documentation snapshot.

## Examples

Ensure that the documentation version ID exists:

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
  its('version') { should eq 'VERSION' }
end
```

Check whether the API path exist for a documentation version:

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
    its('description') { should eq 'DESCRIPTION' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:DocumentationVersion" %}}
