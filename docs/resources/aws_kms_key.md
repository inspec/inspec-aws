---
title: About the aws_kms_key Resource
---

# aws\_kms\_key

Use the `aws_kms_key` InSpec audit resource to test properties of a single AWS KMS Key.

Use aws_kms_key to verify the properties of a single key. Use aws_kms_keys to verify the properties of all or a group of keys.

AWS Key Management Service (AWS KMS) is a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data. AWS KMS lets you create master keys that can never be exported from the service and which can be used to encrypt and decrypt data based on policies you define.

Each AWS KMS Key is uniquely identified by its key_id or arn.

<br>

## Syntax

An aws_kms_key resource block identifies a key by key_arn or the key id.

    # Find a kms key by arn
    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end

    # Find a kms key by just the id
    describe aws_kms_key('4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end

    # Hash syntax for key arn
    describe aws_kms_key(key_arn: 'arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that the specified key does exist

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end

### Test that the specified key is enabled

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should be_enabled }
    end

### Test that the specified key is rotation enabled

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should have_rotation_enabled }
    end

<br>

## Properties

### key\_id

The globally unique identifier for the key.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('key_id') { should cmp '4321dcba-21io-23de-85he-ab0987654321' }
    end

### arn

The ARN identifier of the specified key. An ARN uniquely identifies the key within AWS.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('arn') { should cmp "arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321" }
    end

### creation_date

Specifies the date and time when the key was created.

    # Makes sure that the key was created at least 10 days ago
    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('creation_date') { should be < Time.now - 10 * 86400 }
    end

### created\_days\_ago

Specifies the number of days since the key was created.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('created_days_ago') { should be > 10 }
    end


### key\_state

Specifies the state of the key one of "Enabled", "Disabled", "PendingDeletion", "PendingImport". To just check if the key is enabled or not, use the `be_enabled` matcher.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('key_state') { should cmp "Enabled" }
    end

### description

Specifies the description of the key.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('description') { should cmp "key-description" }
    end

### deletion\_time

Specifies the date and time after which AWS KMS deletes the key. This value is present only when KeyState is PendingDeletion , otherwise this value is nil.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('deletion_time') { should cmp > Time.now + 7 * 86400 }
    end

### invalidation\_time

Provides the date and time until the key is not valid.  Once the key is not valid, AWS KMS deletes the key and it becomes unusable.  This value will be null unless the keys Origin is EXTERNAL and its matcher have_key_expiration is set to true.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its('invalidation_time') { should cmp > Time.now + 7 * 86400 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers (such as `exist`) please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_enabled

The test will pass if the specified key's key_state is set to enabled.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should be_enabled }
    end

### be\_external
Provides whether the source of the key's key material is external or not.  If it is not external than it was created by AWS KMS.  When it is external, the key material was imported from an existing key management infrastructure or the key lacks key material.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its { should be_external }
    end

### be\_managed\_by\_aws

Provides whether or not the key manager is from AWS. If it is not managed by AWS, it is managed by the customer.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its { should be_managed_by_aws }
    end

### have\_key\_expiration

Specifies whether the key's key material expires. This value is null unless the keys Origin is External.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      its { should have_key_expiration }
    end

### have\_rotation\_enabled

The test will pass if automatic rotation of the key material is enabled for the specified key.

    describe aws_kms_key('arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should have_rotation_enabled }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `kms:DescribeKey`, and `kms:GetKeyRotationStatus` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Key Management Service](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awskeymanagementservice.html).
