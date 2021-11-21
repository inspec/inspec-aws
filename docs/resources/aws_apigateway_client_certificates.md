---
title: About the aws_apigateway_client_certificates Resource
platform: aws
---

# aws_apigateway_client_certificates

Use the `aws_apigateway_client_certificates` InSpec audit resource to test properties of multiple AWS API Gateway client certificates.

The `AWS::ApiGateway::ClientCertificate` resource creates a client certificate that API Gateway uses to configure client-side SSL authentication for sending requests to the integration endpoint.

## Syntax

Ensure that the client certificate exists.

    describe aws_apigateway_client_certificates do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS API Gateway client certificate.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| client_certificate_ids | The identifier of the client certificate. | client_certificate_id |
| descriptions | The description of the client certificate. | description |
| pem_encoded_certificates | The PEM-encoded public key of the client certificate, which can be used to configure certificate authentication in the integration endpoint .| pem_encoded_certificate |
| created_dates | The timestamp when the client certificate was created.| created_date |
| expiration_dates | The timestamp when the client certificate will expire.| expiration_date |
| tags | The collection of tags. Each tag element is associated with a given resource. | tags |

## Examples

### Ensure a client certificate ID is available.

    describe aws_apigateway_client_certificates do
      its('client_certificate_ids') { should include 'CLIENT_CERTIFICATE_ID' }
    end

### Ensure a PEM encoded certificate is available.

    describe aws_apigateway_client_certificates do
        its('pem_encoded_certificates') { should include 'PEM_ENCODED_CERTIFICATE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_client_certificates do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_client_certificates do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ClientCertificates` action with `Effect` set to `Allow`.
