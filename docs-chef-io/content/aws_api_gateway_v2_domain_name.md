+++
title = "aws_api_gateway_v2_domain_name resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_domain_name"
identifier = "inspec/resources/aws/aws_api_gateway_v2_domain_name resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_domain_name` InSpec audit resource to test the properties of a specific AWS API Gateway V2 domain name.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 DomainName](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-domainname.html).

## Syntax

Ensure that the domain name exists.

```ruby
describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

## Parameters

`domain_name` _(required)_
: The domain name.

## Properties

`api_mapping_selection_expression`
: The API mapping selection expression.

: **Field**: `api_mapping_selection_expression`

`domain_name`
: A domain name for the API.

: **Field**: `domain_name`

`api_gateway_domain_names`
: A domain name for the API.

: **Field**: `domain_name_status_messages[0].api_gateway_domain_name`

`certificate_arns`
: An AWS-managed certificate is used by the edge-optimized endpoint for this domain name. AWS Certificate Manager is the only supported source.

: **Field**: `domain_name_status_messages[0].certificate_arn`

`certificate_names`
: The user-friendly name of the certificate used by the edge-optimized endpoint for this domain name.

: **Field**: `domain_name_status_messages[0].certificate_name`

`certificate_upload_dates`
: The timestamp when the certificate has been used by the edge-optimized endpoint for this domain name when uploaded.

: **Field**: `domain_name_status_messages[0].certificate_upload_date`

`domain_name_statuses`
: The status of the domain name migration. The valid values are `AVAILABLE`, `UPDATING`, `PENDING_CERTIFICATE_REIMPORT`, and `PENDING_OWNERSHIP_VERIFICATION`.

: **Field**: `domain_name_status_messages[0].domain_name_status`

`domain_name_status_messages`
: An optional text message containing detailed information about the domain name migration status.

: **Field**: `domain_name_status_messages[0].domain_name_status_message`

`endpoint_types`
: The endpoint type.

: **Field**: `domain_name_status_messages[0].endpoint_type`

`hosted_zone_ids`
: The Amazon Route 53 Hosted Zone ID of the endpoint.

: **Field**: `domain_name_status_messages[0].hosted_zone_id`

`security_policies`
: The Transport Layer Security (TLS) version of the security policy for this domain name. The valid values are `TLS_1_0` and `TLS_1_2`.

: **Field**: `domain_name_status_messages[0].security_policy`

`ownership_verification_certificate_arns`
: The ARN of the public certificate issued by ACM to validate ownership of the custom domain.

: **Field**: `domain_name_status_messages[0].ownership_verification_certificate_arn`

`truststore_uri`
: An Amazon S3 URL that specifies the truststore for mutual TLS authentication, for example, s3://bucket-name/key-name.

: **Field**: `mutual_tls_authentication.truststore_uri`

`truststore_version`
: The version of the S3 object that contains the truststore.

: **Field**: `mutual_tls_authentication.truststore_version`

`truststore_warnings`
: A list of warnings that API Gateway returns while processing your truststore. Invalid certificates produce warnings.

: **Field**: `mutual_tls_authentication.truststore_warnings`

`tags`
: The collection of tags associated with a domain name.

: **Field**: `tags`

## Examples

### Test to ensure the domain name is available

```ruby
describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
  its('domain_name') { should eq 'DOMAIN_NAME' }
end
```

### Test to verify the domain status

```ruby
describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
  its('domain_name_configurations[0].domain_name_status') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_domain_name(domain_name: 'DOMAIN_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetDomainNameResponse" %}}
