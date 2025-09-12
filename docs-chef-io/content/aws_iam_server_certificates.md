+++
title = "aws_iam_server_certificates resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_server_certificates"
identifier = "inspec/resources/aws/aws_iam_server_certificates resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_server_certificates` InSpec audit resource to test the properties of all IAM server certificates.

This resource retrieves information about the server certificate, including the server certificate's path, GUID, ARN, and role.

## Syntax

Ensure that a server certificate name exists.

```ruby
describe aws_iam_server_certificates do
  it { should exist }
end
```

For additional information, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Properties

`paths`
: The path to the server certificate.

`server_certificate_names`
: The name that identifies the server certificate.

`server_certificate_ids`
: The stable and unique string identifying the server certificate.

`arns`
: The Amazon Resource Name (ARN) specifying the server certificate.

`upload_date`
: The date when the server certificate is uploaded.

`expiration_date`
: The date on which the certificate is set to expire.

## Examples

**Ensure a server certificate name is available.**

```ruby
describe aws_iam_server_certificates do
  its('server_certificate_name') { should include 'PROFILE_NAME' }
end
```

**Ensure that an arn is available.**

```ruby
describe aws_iam_server_certificates do
    its('arn') { should include 'INSTANCE_PROFILE_NAME_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_server_certificates do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_server_certificates do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the server certificate is available.

```ruby
describe aws_iam_server_certificates do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListServerCertificateResponse" %}}
