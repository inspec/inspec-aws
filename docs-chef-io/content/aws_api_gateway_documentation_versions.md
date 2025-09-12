+++
title = "aws_api_gateway_documentation_versions resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_documentation_versions"
identifier = "inspec/resources/aws/aws_api_gateway_documentation_versions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_documentation_versions` InSpec audit resource to test properties of multiple AWS API Gateway documentation versions.

The `AWS::ApiGateway::DocumentationParts` resource creates a documentation versions for an API.

For additional information, including details on parameters and properties, see the [AWS ApiGateway Documentation Version documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html).

## Syntax

Ensure that the documentation version exists.

```ruby
describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

## Properties

`created_dates`
: The date when the API documentation snapshot is created.

: **Field**: `created_date`

`versions`
: The version identifier of the API documentation snapshot.

: **Field**: `version`

`descriptions`
: The description of the API documentation snapshot.

: **Field**: `description`

## Examples

**Ensure that the documentation versions ID exists.**

```ruby
describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
  its('versions') { should include 'VERSION' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the documentation versions is available.

```ruby
describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client::DocumentationVersions" %}}
