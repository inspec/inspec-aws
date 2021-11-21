---
title: About the aws_transfer_user Resource
platform: aws
---

# aws\_transfer\_user

Use the `aws_transfer_user` InSpec audit resource to test properties of a single Transfer user.

## Syntax

Ensure that a Transfer user exists.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
      it { should exist }
    end

## Parameters

`server_id` _(required)_

The system-assigned unique identifier for a server that this user has been assigned to.

`user_name` _(required)_

The name of the user assigned to one or more servers.

For additional information, see the [AWS documentation on Transfer user](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html).

## Properties

| Property | Description|
| --- | --- |
| server_id | The system-assigned unique identifier for a server that this user has been assigned to. |
| user (home_directory) | The landing directory for a user when they log in to the server using the client.  |
| user (home_directory_mappings) | Logical directory mappings that specify what S3 paths and keys should be visible to your user and how you want to make them visible. |
| user (home_directory_mappings (entry)) | The entry for `HomeDirectoryMappings`. |
| user (home_directory_mappings (target)) | The map target that is used in a `HomeDirectorymapEntry`.  |
| user (home_directory_type) | The type of landing directory you want your users' home directory to be when they log into the server. |
| user (policy) | A scope-down policy for your user so you can use the same IAM role across multiple users. |
| user (role) | The ARN of the IAM role that controls your users' access to your Amazon S3 bucket or EFS file system. |
| user (ssh_public_keys (date_imported)) | The date that the public key was added to the user account. |
| user (ssh_public_keys (ssh_public_key_body)) | The content of the SSH public key as specified by the PublicKeyId. |
| user (ssh_public_keys (ssh_public_key_id)) | The `SshPublicKeyId` parameter contains the identifier of the public key.  |
| user (tags) | Key-value pairs that can be used to group and search for users.  |
| user (user_name) | The user name associated with a server as specified by the `ServerId`. |

## Examples

### Ensure an user is available.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
      its('user_name') { should eq 'USER_NAME' }
    end

### Ensure that the server ID is available.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
        its('server_id') { should eq 'SERVER_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the user is available.

    describe aws_transfer_user(server_id: "SERVER_ID", user_name: 'USER_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Transfer:Client:DescribeUserResponse` action with `Effect` set to `Allow`.