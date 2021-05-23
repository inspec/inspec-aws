---
title: About the aws_transfer_user Resource
platform: aws
---

# aws\_transfer\_user

Use the `aws_transfer_user` InSpec audit resource to test properties of a single specific Transfer User.

The AWS::Transfer::User resource creates a user and associates them with an existing server. You can only create and associate users with servers that have the IdentityProviderType set to SERVICE_MANAGED. Using parameters for CreateUser, you can specify the user name, set the home directory, store the user's public key, and assign the user's AWS Identity and Access Management (IAM) role. You can also optionally add a scope-down policy, and assign metadata with tags that can be used to group and search for users.

## Syntax

Ensure that an identity pool exists.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
      it { should exist }
    end

## Parameters

`server_id user_name` _(required)_

For additional information, see the [AWS documentation on Transfer User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html).

## Properties

| Property | Description|
| --- | --- |
| server_id | The server id of the user. |
| user (home_directory) | The home directory of the user. |
| user (home_directory_mappings) | The home directory mappings of the user. |
| user (home_directory_mappings (entry)) | The entry of the home directory mappings of the user. |
| user (home_directory_mappings (target)) | The target of the home directory mappings of the user. |
| user (home_directory_type) | The home directory type of the user. |
| user (policy) | The policy of the user. |
| user (role) | The role of the user. |
| user (ssh_public_keys (date_imported)) | The date imported of the ssh public keys of the user. |
| user (ssh_public_keys (ssh_public_key_body)) | The ssh public key body of the ssh public keys of the user. |
| user (ssh_public_keys (ssh_public_key_id)) | The ssh public key id of the ssh public keys of the user. |
| user (tags) | The tags of the user. |
| user (user_name) | The user name of the user. |

## Examples

### Ensure an user is available.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
      its('identity_pool_id') { should eq 'test' }
    end

### Ensure that the server id is available.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
        its('server_id') { should eq 'test' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the user is available.
    describe aws_transfer_user(server_id: "test", user_name: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `transfer_client:client:describe_user` action with `Effect` set to `Allow`.