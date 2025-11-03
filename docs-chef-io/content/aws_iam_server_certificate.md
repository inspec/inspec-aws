+++
title = "aws_iam_server_certificate resource"

draft = false


[menu.aws]
title = "aws_iam_server_certificate"
identifier = "inspec/resources/aws/aws_iam_server_certificate resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_server_certificate` InSpec audit resource to test the properties of a single IAM server certificate.

This resource retrieves information about the specified server certificate, including the server certificate's path, GUID, ARN, and role.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Syntax

Ensure that a server certificate name exists.

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
  it { should exist }
end
```

## Parameters

`server_certificate_name` _(required)_

## Properties

`path`
: The path to the server certificate.

`server_certificate_name`
: The name that identifies the server certificate.

`server_certificate_id`
: The stable and unique string identifying the server certificate.

`arn`
: The Amazon Resource Name (ARN) specifying the server certificate.

`upload_date`
: The date when the server certificate is uploaded.

`expiration`
: The date on which the certificate is set to expire.

## Examples

Ensure a server certificate name is available:

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
  its('server_certificate_name') { should eq 'PROFILE_NAME' }
end
```

Ensure that an arn is available:

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
    its('arn') { should eq 'INSTANCE_PROFILE_NAME_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the server certificate is available.

```ruby
describe aws_iam_server_certificate(server_certificate_name: 'CERTIFICATE_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetServerCertificateResponse" %}}
