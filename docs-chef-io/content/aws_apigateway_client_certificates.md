+++
title = "aws_apigateway_client_certificates resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_apigateway_client_certificates"
identifier = "inspec/resources/aws/aws_apigateway_client_certificates resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_client_certificates` InSpec audit resource to test properties of multiple AWS API Gateway client certificates.

The `AWS::ApiGateway::ClientCertificate` resource creates a client certificate that API Gateway uses to configure client-side SSL authentication for sending requests to the integration endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS API Gateway client certificate.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html).

## Syntax

Ensure that the client certificate exists.

```ruby
describe aws_apigateway_client_certificates do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`client_certificate_ids`
: The identifier of the client certificate.

: **Field**: `client_certificate_id`

`descriptions`
: The description of the client certificate.

: **Field**: `description`

`pem_encoded_certificates`
: The PEM-encoded public key of the client certificate, which can be used to configure certificate authentication in the integration endpoint .

: **Field**: `pem_encoded_certificate`

`created_dates`
: The timestamp when the client certificate was created.

: **Field**: `created_date`

`expiration_dates`
: The timestamp when the client certificate will expire.

: **Field**: `expiration_date`

`tags`
: The collection of tags. Each tag element is associated with a given resource.

: **Field**: `tags`

## Examples

**Ensure a client certificate ID is available.**

```ruby
describe aws_apigateway_client_certificates do
  its('client_certificate_ids') { should include 'CLIENT_CERTIFICATE_ID' }
end
```

**Ensure a PEM encoded certificate is available.**

```ruby
describe aws_apigateway_client_certificates do
    its('pem_encoded_certificates') { should include 'PEM_ENCODED_CERTIFICATE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_client_certificates do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_client_certificates do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:ClientCertificates" %}}
