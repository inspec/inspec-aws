+++
title = "aws_api_gateway_v2_domain_names resource"

draft = false


[menu.aws]
title = "aws_api_gateway_v2_domain_names"
identifier = "inspec/resources/aws/aws_api_gateway_v2_domain_names resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_domain_names` InSpec audit resource to test properties of multiple AWS API Gateway V2 domain names.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 DomainName](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-domainname.html).

## Syntax

Ensure that the domain name exists.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`authorizer_credentials_arns`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

: **Field**: `authorizer_credentials_arn`

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

### Test to verify if domain configurations are set

```ruby
describe aws_api_gateway_v2_domain_names do
  its('domain_name_configurations') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_domain_names do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetDomainNamesResponse" %}}
