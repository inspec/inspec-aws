+++
title = "aws_api_gateway_domain_names resource"

draft = false


[menu.aws]
title = "aws_api_gateway_domain_names"
identifier = "inspec/resources/aws/aws_api_gateway_domain_names resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_domain_names` InSpec audit resource to test the properties of multiple AWS API Gateway domain names.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway DomainName](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-domainname.html).

## Syntax

Ensure that the domain name exists.

```ruby
describe aws_api_gateway_domain_names do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`domain_names`
: The custom domain name as an API hostname. For example, my-api.example.com.

: **Field**: `domain_name`

`certificate_names`
: The certificate name used by the edge-optimized endpoint for this domain name.

: **Field**: `certificate_name`

`certificate_arns`
: The reference to an AWS-managed certificate that is used by the edge-optimized endpoint for this domain name. AWS Certificate Manager is the only supported source.

: **Field**: `certificate_arn`

`certificate_upload_dates`
: The timestamp when the certificate used by the edge-optimized endpoint for this domain name is uploaded.

: **Field**: `certificate_upload_date`

`regional_domain_names`
: The domain name associated with the regional endpoint for this custom domain name. You can set up this association by adding a DNS record that points the custom domain name to this regional domain name. The regional domain name is returned by API Gateway when creating a regional endpoint.

: **Field**: `regional_domain_name`

`regional_hosted_zone_ids`
: The region-specific Amazon Route 53 Hosted Zone ID of the regional endpoint. For more information, see [Set up a Regional Custom Domain Name and AWS Regions and Endpoints for API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-regional-api-custom-domain-create.html).

: **Field**: `regional_hosted_zone_id`

`regional_certificate_names`
: The certificate name used for validating the regional domain name.

: **Field**: `regional_certificate_name`

`regional_certificate_arns`
: The reference to an AWS-managed certificate used to validate the regional domain name. AWS Certificate Manager is the only supported source.

: **Field**: `regional_certificate_arn`

`distribution_domain_names`
: The Amazon CloudFront distribution domain name associated with this custom domain name for an edge-optimized endpoint. You can set up this association when adding a DNS record pointing the custom domain name to this distribution name. For more information about CloudFront distributions, see the [Amazon CloudFront documentation](https://docs.aws.amazon.com/cloudfront/index.html).

: **Field**: `distribution_domain_name`

`distribution_hosted_zone_ids`
: The region-agnostic Amazon Route 53 Hosted Zone ID of the edge-optimized endpoint.

: **Field**: `distribution_hosted_zone_id`

`endpoint_configurations`
: The endpoint configuration of the domain name showing the endpoint types of the domain name.

: **Field**: `endpoint_configuration`

`domain_name_statuses`
: The status of the domain name migration. The valid values are `AVAILABLE` and `UPDATING`. If the status is `UPDATING`, the domain cannot be modified further until the existing operation is complete. If it is `AVAILABLE`, the domain can be updated.

: **Field**: `domain_name_status`

`domain_name_status_messages`
: An optional text message containing detailed information about the status of the domain name migration.

: **Field**: `domain_name_status_message`

`security_policies`
: The Transport Layer Security (TLS) version and cipher suite for this domain name. The valid values are `TLS_1_0` and `TLS_1_2`.

: **Field**: `security_policy`

`tags`
: The collection of tags.

: **Field**: `tags`

`mutual_tls_authentications`
: The mutual TLS authentication configuration for a custom domain name. If specified, API Gateway performs two-way authentication between the client and the server. Clients must present a trusted certificate to access your API.

: **Field**: `mutual_tls_authentication`

`ownership_verification_certificate_arns`
: The ARN of the public certificate issued by ACM to validate ownership of your custom domain.

: **Field**: `ownership_verification_certificate_arn`

## Examples

### Test to ensure the domain name is available

```ruby
describe aws_api_gateway_domain_names do
  its('domain_names') { should include 'DOMAIN_NAME' }
end
```

### Test to ensure a regional hosted zone ID is available

```ruby
describe aws_api_gateway_domain_names do
  its('regional_hosted_zone_ids') { should include 'REGIONAL_HOSTED_ZONE_ID' }
end
```

### Test to ensure that the domain name status includes `AVAILABLE`

```ruby
describe aws_api_gateway_domain_names do
  its('domain_name_statuses') { should include 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_domain_names do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_domain_names do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:DomainNames" %}}
