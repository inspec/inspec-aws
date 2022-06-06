+++
title = "aws_api_gateway_domain_name resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_domain_name"
identifier = "inspec/resources/aws/aws_api_gateway_domain_name resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_domain_name` InSpec audit resource to test the properties of a single specific AWS APIGateway DomainName.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway DomainName](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-domainname.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the domain name exists.

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_

: The custom domain name as an API host name, for example, my-api.example.com .

## Properties

`domain_name`
: The custom domain name as an API host name, for example, my-api.example.com .

: **Field**: `domain_name`

`certificate_name`
: The name of the certificate that will be used by edge-optimized endpoint for this domain name.

: **Field**: `certificate_name`

`certificate_arn`
: The reference to an AWS-managed certificate that will be used by edge-optimized endpoint for this domain name. AWS Certificate Manager is the only supported source.

: **Field**: `certificate_arn`

`certificate_upload_date`
: The timestamp when the certificate that was used by edge-optimized endpoint for this domain name was uploaded.

: **Field**: `certificate_upload_date`

`regional_domain_name`
: The domain name associated with the regional endpoint for this custom domain name. You set up this association by adding a DNS record that points the custom domain name to this regional domain name. The regional domain name is returned by API Gateway when you create a regional endpoint.

: **Field**: `regional_domain_name`

`regional_hosted_zone_id`
: The region-specific Amazon Route 53 Hosted Zone ID of the regional endpoint. For more information, see Set up a Regional Custom Domain Name and AWS Regions and Endpoints for API Gateway.

: **Field**: `regional_hosted_zone_id`

`regional_certificate_name`
: The name of the certificate that will be used for validating the regional domain name.

: **Field**: `regional_certificate_name`

`regional_certificate_arn`
: The reference to an AWS-managed certificate that will be used for validating the regional domain name. AWS Certificate Manager is the only supported source.

: **Field**: `regional_certificate_arn`

`distribution_domain_name`
: The domain name of the Amazon CloudFront distribution associated with this custom domain name for an edge-optimized endpoint. You set up this association when adding a DNS record pointing the custom domain name to this distribution name. For more information about CloudFront distributions, see the Amazon CloudFront documentation.

: **Field**: `distribution_domain_name`

`distribution_hosted_zone_id`
: The region-agnostic Amazon Route 53 Hosted Zone ID of the edge-optimized endpoint. The valid value is Z2FDTNDATAQYW2 for all the regions.

: **Field**: `distribution_hosted_zone_id`

`endpoint_configuration_types`
: The endpoint type. The valid values are EDGE for edge-optimized API setup, most suitable for mobile applications; REGIONAL for regional API endpoint setup, most suitable for calling from AWS Region; and PRIVATE for private APIs.

: **Field**: `endpoint_configuration.types`

`endpoint_configuration_vpc_endpoint_ids`
: A list of VpcEndpointIds of an API (RestApi) against which to create Route53 ALIASes. It is only supported for PRIVATE endpoint type.

: **Field**: `endpoint_configuration.vpc_endpoint_ids`

`domain_name_status`
: The status of the DomainName migration. The valid values are AVAILABLE and UPDATING . If the status is UPDATING , the domain cannot be modified further until the existing operation is complete. If it is AVAILABLE , the domain can be updated.

: **Field**: `domain_name_status`

`domain_name_status_message`
: An optional text message containing detailed information about status of the DomainName migration.

: **Field**: `domain_name_status_message`

`security_policy`
: The Transport Layer Security (TLS) version + cipher suite for this DomainName. The valid values are TLS_1_0 and TLS_1_2 .

: **Field**: `security_policy`

`tags`
: The collection of tags.

: **Field**: `tags`

`mutual_tls_authentication.truststore_uri`
: An Amazon S3 URL that specifies the truststore for mutual TLS authentication, for example s3://bucket-name/key-name . The truststore can contain certificates from public or private certificate authorities. To update the truststore, upload a new version to S3, and then update your custom domain name to use the new version. To update the truststore, you must have permissions to access the S3 object.

: **Field**: `mutual_tls_authentication.truststore_uri`

`mutual_tls_authentication.truststore_version`
: The version of the S3 object that contains your truststore. To specify a version, you must have versioning enabled for the S3 bucket.

: **Field**: `mutual_tls_authentication.truststore_version`

`mutual_tls_authentication_truststore_warnings`
: A list of warnings that API Gateway returns while processing your truststore. Invalid certificates produce warnings. Mutual TLS is still enabled, but some clients might not be able to access your API. To resolve warnings, upload a new truststore to S3, and then update you domain name to use the new version.

: **Field**: `mutual_tls_authentication.truststore_warnings`

`ownership_verification_certificate_arn`
: The ARN of the public certificate issued by ACM to validate ownership of your custom domain. Only required when configuring mutual TLS and using an ACM imported or private CA certificate ARN as the regionalCertificateArn.

: **Field**: `ownership_verification_certificate_arn`

## Examples

**Ensure the domain name is available.**

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  its('domain_name') { should eq 'DOMAIN_NAME' }
end
```

**Ensure an regional_hosted_zone_id is available.**

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  its('regional_hosted_zone_id') { should eq 'REGIONAL_HOSTED_ZONE_ID' }
end
```

**Ensure that the domain name status is `AVAILABLE`.**

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  its('domain_name_status') { should eq 'AVAILABLE' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:DomainName" %}}
