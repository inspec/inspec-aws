---
title: About the aws_transfer_users Resource
platform: aws
---

# aws\_transfer\_users

Use the `aws_transfer_users` InSpec audit resource to test properties of multiple Transfer users.

## Syntax

Ensure that an user exists.

    describe aws_transfer_users do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Transfer user](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html).

## Properties

| Property | Description|
| --- | --- |
| ARNs | The ARNs of the user. |
| home_directories | The landing directories for users when they log in to the server using the client. |
| home_directory_types | The landing directory types you want your users' home directory to be when they log into the server. |
| roles | The ARNs of the IAM roles that controls your users' access to your Amazon S3 bucket or EFS file system. |
| ssh_public_key_count | The ssh public key count of the user. |
| user_names | The user names associated with a server as specified by the `ServerId`. |

## Examples

### Ensure an ARN is available.

    describe aws_transfer_users do
      its('arns') { should include 'USER_ARN' }
    end

### Ensure that the roles is available.

    describe aws_transfer_users do
        its('roles') { should include 'USER_ROLE_ARN' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Transfer:Client:ListUsersResponse` action with `Effect` set to `Allow`.
