---
title: About the aws_iam_oidc_providers Resource
platform: aws
---

# aws\_iam\_oidc\_providers

Use the `aws_iam_oidc_providers` InSpec audit resource to test properties of a set of IAM OIDC Provider.

This resource retrieves information about all the OIDC Providers.

## Syntax

Ensure that OIDC providers exists.

    describe aws_iam_oidc_providers do
      it { should exist }
    end


For additional information, see the [AWS documentation on IAM OIDC Provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Properties

| Property | Description|
| --- | --- |
| arns | The Amazon Resource Name (ARN). ARNs are unique identifiers for Amazon Web Services resources. |

## Examples

### Ensure a OIDC Provider is available.

    describe aws_iam_oidc_providers do
      its('arns') { should include 'open_id_connect_provider_arn' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam_client.list_open_id_connect_provider` action with `Effect` set to `Allow`.