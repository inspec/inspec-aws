---
title: About the aws_iam_server_certificates Resource
platform: aws
---

# aws_iam_server_certificates

Use the `aws_iam_server_certificates` InSpec audit resource to test the properties of all IAM server certificates.

This resource retrieves information about the server certificate, including the server certificate's path, GUID, ARN, and role.

## Syntax

Ensure that a server certificate name exists.

    describe aws_iam_server_certificates do
      it { should exist }
    end

For additional information, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Properties

| Property | Description|
| --- | --- |
| paths | The path to the server certificate. |
| server_certificate_names | The name that identifies the server certificate. |
| server_certificate_ids | The stable and unique string identifying the server certificate. |
| arns | The Amazon Resource Name (ARN) specifying the server certificate. |
| upload_date | The date when the server certificate is uploaded. |
| expiration_date | The date on which the certificate is set to expire. |

## Examples

### Ensure a server certificate name is available

    describe aws_iam_server_certificates do
      its('server_certificate_name') { should include 'PROFILE_NAME' }
    end

### Ensure that an arn is available
    describe aws_iam_server_certificates do
        its('arn') { should include 'INSTANCE_PROFILE_NAME_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_server_certificates do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_server_certificates do
      it { should_not exist }
    end

### be_available

Use `should` to check if the server certificate is available.

    describe aws_iam_server_certificates do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListServerCertificateResponse` action with `Effect` set to `Allow`.
