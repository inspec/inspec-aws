+++
title = "aws_api_gateway_v2_domain_names Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_domain_names"
identifier = "inspec/resources/aws/aws_api_gateway_v2_domain_names Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_domain_names` InSpec audit resource to test properties of multiple AWS APIGatewayV2 DomainNames.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 DomainName](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-domainname.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the domain name exists.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should exist }
end
```

## Parameters

This resource doesn't require any parameters.

## Properties

`authorizer_credentials_arns`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

: **Field**: `authorizer_credentials_arn`

## Examples

`api_mapping_selection_expressions`
: The API mapping selection expression.

: **Field**: `api_mapping_selection_expression`

`domain_names`
: A domain name for the API.

: **Field**: `domain_name`

`domain_name_configurations`
: The configuration of the domain name.

: **Field**: `domain_name_configurations`

`mutual_tls_authentications`
: This is TLS authentication.

: **Field**: `mutual_tls_authentication`

`tags`
: The collection of tags associated with a domain name.

: **Field**: `tags`

## Examples

### Test to ensure a domain name is available

```ruby
describe aws_api_gateway_v2_domain_names do
  its('domain_names') { should eq 'DOMAIN_NAME' }
end
```

### Verify the whether the domain configurations are there or not

```ruby
describe aws_api_gateway_v2_domain_names do
  its('domain_name_configurations') { should eq 'AVAILABLE' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGatewayv2:Client:GetDomainNamesResponse" %}}
