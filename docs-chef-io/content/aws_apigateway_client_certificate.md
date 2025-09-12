+++
title = "aws_apigateway_client_certificate resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_apigateway_client_certificate"
identifier = "inspec/resources/aws/aws_apigateway_client_certificate resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_client_certificate` InSpec audit resource to test properties of a single specific AWS API Gateway client certificate.

The `AWS::ApiGateway::ClientCertificate` resource creates a client certificate that API Gateway uses to configure client-side SSL authentication for sending requests to the integration endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway ClientCertificate.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html).

## Syntax

Ensure that the client certificate exists.

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
  it { should exist }
end
```

## Parameters

`client_certificate_id` _(required)_

: The identifier of the client certificate.

## Properties

`client_certificate_id`
: The identifier of the client certificate.

`description`
: The description of the client certificate.

`pem_encoded_certificate`
: The PEM-encoded public key of the client certificate, which can be used to configure certificate authentication in the integration endpoint .

`created_date`
: The timestamp when the client certificate was created.

`expiration_date`
: The timestamp when the client certificate will expire.

`tags`
: The collection of tags. Each tag element is associated with a given resource.

## Examples

Ensure a client certificate id is available:

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
  its('client_certificate_id') { should eq 'CLIENT_CERTIFICATE_ID' }
end
```

Ensure a pem encoded certificate is available:

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
    its('pem_encoded_certificate') { should eq 'PEM_ENCODED_CERTIFICATE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:ClientCertificate" %}}
