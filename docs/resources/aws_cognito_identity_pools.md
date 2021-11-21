---
title: About the aws_cognito_identity_pools Resource
platform: aws
---

# aws\_cognito\_identity\_pools

Use the `aws_cognito_identity_pools` InSpec audit resource to test properties of multiple Cognito identity pools.

## Syntax

Ensure that an identity pool exists.

    describe aws_cognito_identity_pools do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Cognito identity pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-identitypool.html).

## Properties

| Property | Description|
| --- | --- |
| identity_pool_ids | The IDs of the identity pool. |
| identity_pool_names | The names of the identity pool. |

## Examples

### Ensure an identity pool is available.

    describe aws_cognito_identity_pools do
      its('identity_pool_ids') { should include 'IDENTITY_POOL_ID' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_cognito_identity_pools do
        its('identity_pool_names') { should include 'IDENTITY_POOL_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_cognito_identity_pools do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_cognito_identity_pools do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identity pool is available.
    describe aws_cognito_identity_pools do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CognitoIdentity:Client:ListIdentityPoolsResponse` action with `Effect` set to `Allow`.
