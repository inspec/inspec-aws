---
title: About the aws_apigateway_client_certificate Resource
platform: aws
---

# aws_apigateway_client_certificate

Use the `aws_apigateway_client_certificate` InSpec audit resource to test properties of a single specific AWS API Gateway client certificate.

The `AWS::ApiGateway::ClientCertificate` resource creates a client certificate that API Gateway uses to configure client-side SSL authentication for sending requests to the integration endpoint.

## Syntax

Ensure that the client certificate exists.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      it { should exist }
    end

## Parameters

`client_certificate_id` _(required)_

The identifier of the client certificate.

For additional information, see the [AWS documentation on AWS APIGateway ClientCertificate.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html).

## Properties

| Property | Description |
| --- | --- |
| client_certificate_id | The identifier of the client certificate. |
| description | The description of the client certificate. |
| pem_encoded_certificate | The PEM-encoded public key of the client certificate, which can be used to configure certificate authentication in the integration endpoint .|
| created_date | The timestamp when the client certificate was created.|
| expiration_date | The timestamp when the client certificate will expire.|
| tags | The collection of tags. Each tag element is associated with a given resource. |

## Examples

### Ensure a client certificate id is available.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      its('client_certificate_id') { should eq 'CLIENT_CERTIFICATE_ID' }
    end

### Ensure a pem encoded certificate is available.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
        its('pem_encoded_certificate') { should eq 'PEM_ENCODED_CERTIFICATE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_client_certificate(client_certificate_id: 'CLIENT_CERTIFICATE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ClientCertificate` action with `Effect` set to `Allow`.
