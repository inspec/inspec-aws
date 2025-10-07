+++
title = "aws_apigateway_base_path_mappings resource"

draft = false


[menu.aws]
title = "aws_apigateway_base_path_mappings"
identifier = "inspec/resources/aws/aws_apigateway_base_path_mappings resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_base_path_mappings` InSpec audit resource to test properties of multiple AWS API Gateway base path mappings.

The `AWS::ApiGateway::BasePathMapping` resource creates a base path that clients who call your API must use in the invocation URL.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway BasePathMapping.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Syntax

Ensure that the base path mappings exists.

```ruby
describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_

: The domain name of the BasePathMapping resource to be described.

## Properties

`base_paths`
: The base path name that callers of the API must provide as part of the URL after the domain name.

: **Field**: `base_path`

`rest_api_ids`
: The string identifier of the associated RestApi.

: **Field**: `rest_api_id`

`stages`
: The name of the associated stage.

: **Field**: `stage`

## Examples

Ensure a base path is available:

```ruby
describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
  its('base_paths') { should include 'BASE_PATH')' }
end
```

Ensure that stage name is available:

```ruby
describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
    its('stages') { should include 'STAGE_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:BasePathMappings" %}}
