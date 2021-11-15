---
title: About the aws_iam_ssh_public_keys Resource
platform: aws
---

# aws_iam_ssh_public_keys

Use the `aws_iam_ssh_public_keys` InSpec audit resource to test the properties of the plural resource of an AWS SSH public key for an IAM user.

## Syntax

Ensure that the public key exists by passing the parameter user_name.

    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
      it { should exist }
    end

Ensure that the public key exists without passing any parameter.

    describe aws_iam_ssh_public_keys do
      it { should exist }
    end

## Parameters

`user_name` _(required)_ 

The IAM user name associated with the SSH public key. The above required parameter is optional.

For additional information, see the [AWS documentation on AWS IAM AccessKey.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html).

## Properties

| Property           | Description                                           | Field_Name        |
| :----------------: | :---------------------------------------------------: | :---------------: |
| user_names         | The IAM user name associated with the SSH public key. | user_name         |
| ssh_public_key_ids | The unique identifier for the SSH public key.         | ssh_public_key_id |
| statuses           | The status of the SSH public key.                     | status            |
| upload_dates       | The date and time, in ISO 8601 date-time format, when the SSH public key is uploaded. | upload_date |

## Examples

### Ensure a user name is available

    describe aws_iam_ssh_public_keys do
      its('user_names') { should include 'USER_NAME' }
    end

### Ensure an ssh public key id is available

    describe aws_iam_ssh_public_keys do
        its('ssh_public_key_ids') { should include 'KEY_ID' }
    end

### Ensure status is 'Active' by passing the parameter user_name.

    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
        its('statuses') { should include 'Active' }
    end

### Ensure status is 'Active' without passing any parameter.

    describe aws_iam_ssh_public_keys do
        its('statuses') { should include 'Active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
      it { should exist }
    end

    describe aws_iam_ssh_public_keys do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
      it { should_not exist }
    end

    describe aws_iam_ssh_public_keys do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
      it { should be_available }
    end

    describe aws_iam_ssh_public_keys do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListSSHPublicKeysResponse` action with `Effect` set to `Allow`.
