---
title: About the aws_iam_oidc_providers Resource
platform: aws
---

# aws\_iam\_oidc\_providers

Use the `aws_iam_oidc_providers` InSpec audit resource to test properties of a set of AWS IAM OpenID Connect (OIDC) providers.

This resource retrieves information about all OIDC providers.

## Syntax

Ensure that an OIDC provider exists.

    describe aws_iam_oidc_providers do
      it { should exist }
    end

For additional information, see the [AWS documentation on IAM OIDC provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Parameters

This resource does not require any parameters.

## Properties

| Property | Description|
| --- | --- |
| arns | The Amazon Resource Name (ARN). |

## Examples

### Ensure a OIDC Provider is available.

    describe aws_iam_oidc_providers do
      its('arns') { should include 'OIDC_PROVIDER_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_oidc_providers do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_oidc_providers do
      it { should_not exist }
    end

### be_available

Use `should` to check if the OIDC Provider is available.

    describe aws_iam_oidc_providers do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListOpenIDConnectProviderTagsResponse` action with `Effect` set to `Allow`.
