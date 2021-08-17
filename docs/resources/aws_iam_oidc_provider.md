---
title: About the aws_iam_oidc_provider Resource
platform: aws
---

# aws\_iam\_oidc\_provider

Use the `aws_iam_oidc_provider` InSpec audit resource to test properties of a single IAM OIDC Provider.

This resource retrieves information about the specified OIDC Provider.

## Syntax

Ensure that a OIDC provider exists.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
      it { should exist }
    end

## Parameters

`open_id_connect_provider_arn` _(required)_

For additional information, see the [AWS documentation on IAM OIDC Provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Properties

| Property | Description|
| --- | --- |
| url | The URL that the IAM OIDC provider resource object is associated with. |
| create_date | The date and time when the IAM OIDC provider resource object was created in the account. |
| tags | A list of tags that are attached to the specified IAM OIDC provider. |

## Examples

### Ensure a  url is available.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
      its('url') { should eq 'open_id_connect_provider_arn.com' }
    end

### Ensure that tags are available.
    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
        its('tags') { should eq ':test_tag => 'oidc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the OIDC Provider is available.

    describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'open_id_connect_provider_arn') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam_client.get_open_id_connect_provider` action with `Effect` set to `Allow`.