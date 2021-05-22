---
title: About the aws_transfer_users Resource
platform: aws
---

# aws\_transfer\_users

Use the `aws_transfer_users` InSpec audit resource to test properties of a single specific Transfer User.

The AWS::Transfer::User resource creates a user and associates them with an existing server. You can only create and associate users with servers that have the IdentityProviderType set to SERVICE_MANAGED. Using parameters for CreateUser, you can specify the user name, set the home directory, store the user's public key, and assign the user's AWS Identity and Access Management (IAM) role. You can also optionally add a scope-down policy, and assign metadata with tags that can be used to group and search for users.

## Syntax

Ensure that an user exists.
    describe aws_transfer_users do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Transfer User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html).

## Properties

| Property | Description|
| --- | --- |
| arns | The arns of the user. |
| home_directories | The home directories of the user. |
| home_directory_types | The home directory types of the user. |
| roles | The roles of the user. |
| ssh_public_key_counts | The ssh public key counts of the user. |
| user_names | The user names of the user. |

## Examples

### Ensure an arns is available.
    describe aws_transfer_users do
      its('arns') { should include 'test' }
    end

### Ensure that the roles is available.
    describe aws_transfer_users do
        its('roles') { should include 'test' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_transfer_users do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_transfer_users do
      it { should_not exist }
    end

### be_available

Use `should` to check if the user is available.
    describe aws_transfer_users do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `transfer_client:client:list_users` action with `Effect` set to `Allow`.