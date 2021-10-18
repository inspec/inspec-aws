---
title: About the aws_api_gateway_client_certificates Resource
platform: aws
---

# aws_api_gateway_client_certificates

Use the `aws_api_gateway_client_certificates` InSpec audit resource to test properties of a the plural resource of AWS APIGateway ClientCertificate.

The AWS::ApiGateway::ClientCertificate resource creates a client certificate that API Gateway uses to configure client-side SSL authentication for sending requests to the integration endpoint.

## Syntax

Ensure that the client certificate exists.

    describe aws_api_gateway_client_certificates do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS APIGateway ClientCertificate.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| client_certificate_ids | The identifier of the client certificate. | client_certificate_id | 
| descriptions | The description of the client certificate. | description | 
| pem_encoded_certificates | The PEM-encoded public key of the client certificate, which can be used to configure certificate authentication in the integration endpoint. | pem_encoded_certificate | 
| created_dates | The timestamp when the client certificate was created. | created_date | 
| expiration_dates | The timestamp when the client certificate will expire. | expiration_date | 
| tags | The collection of tags. | tags | 

## Examples

### Ensure a client certificate id is available.
    describe aws_api_gateway_client_certificates do
      its('client_certificate_ids') { should include 'CLIENT_CERTIFICATE_ID' }
    end

### Ensure a pem encoded certificate is available.
    describe aws_api_gateway_client_certificates do
        its('pem_encoded_certificates') { should include 'PEM_ENCODED_CERITFICATE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_client_certificates do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_client_certificates do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_api_gateway_client_certificates do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ClientCertificates` action with `Effect` set to `Allow`.