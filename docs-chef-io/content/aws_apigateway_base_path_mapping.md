+++
title = "aws_apigateway_base_path_mapping resource"

draft = false


[menu.aws]
title = "aws_apigateway_base_path_mapping"
identifier = "inspec/resources/aws/aws_apigateway_base_path_mapping resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_base_path_mapping` Chef InSpec audit resource to test properties of a single specific AWS API Gateway base path mapping.

The `AWS::ApiGateway::BasePathMapping` resource creates a base path that clients who call your API must use in the invocation URL.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway BasePathMapping.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Syntax

Test that the base path mapping exists.

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_

: The domain name of the base path mapping resource to be described.

`base_path` _(required)_

: The base path name that callers of the API must provide as part of the URL after the domain name.

## Properties

`base_path`
: The base path name that callers of the API must provide as part of the URL after the domain name.

`rest_api_id`
: The string identifier of the associated RestApi.

`stage`
: The name of the associated stage.

## Examples

Test that a base path is available:

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
  its('base_path') { should eq 'BASE_PATH')' }
end
```

Test that a stage name is available:

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
    its('stage') { should eq 'StageName' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:BasePathMapping" %}}
