---
title: About the aws_iam_oidc_provider Resource
platform: aws
---

# aws\_iam\_oidc\_provider

Use the `aws_iam_oidc_provider` InSpec audit resource to test properties of a single IAM OpenID Connect (OIDC) provider.

This resource retrieves information about the specified OIDC provider.

## Syntax

Ensure that an OIDC provider exists.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
      it { should exist }
    end

## Parameters

`open_id_connect_provider_arn` _(required)_

The Amazon Resource Name (ARN) of the OIDC provider resource object in IAM to get information for.


For additional information, see the [AWS documentation on IAM OIDC provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Properties

| Property | Description|
| --- | --- |
| url | The URL that the IAM OIDC provider resource object is associated with. |
| create_date | The date and time when the IAM OIDC provider resource object was created in the account. |
| tags | A list of tags that are attached to the specified IAM OIDC provider. |

## Examples

### Ensure an URL is available.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
      its('url') { should eq 'example.com' }
    end

### Ensure that tags are available.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
        its('tags') { should eq ':TAG => 'TAG_VALUE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:GetOpenIDConnectProviderResponse` action with `Effect` set to `Allow`.
