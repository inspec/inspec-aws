---
title: About the aws_secretsmanager_secrets Resource
platform: aws
---

# aws\_secretsmanager\_secrets

Use the `aws_secretsmanager_secrets` InSpec audit resource to test properties of multiple AWS Secret Manager secrets.

The `AWS::SecretsManager::Secret` resource creates a secret and stores it in Secrets Manager.

## Syntax

Ensure that a secret exists.

    describe aws_secretsmanager_secrets do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on AWS Secret Manager Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html).

## Properties

| Property | Description | Fields | 
| --- | --- | --- |
| arns | The Amazon Resource Name (ARN) of the secret. |
| names | The friendly name of the secret. |
| descriptions | The user-provided description of the secret. |
| kms_key_ids | The ARN or alias of the AWS KMS customer master key (CMK) used to encrypt the `SecretString` and `SecretBinary` fields in each version of the secret. |
| rotation_enabled | Indicates whether automatic, scheduled rotation is enabled for this secret. |
| rotation_lambda_arns | The ARN of an AWS Lambda function invoked by Secrets Manager to rotate and expire the secret either automatically per the schedule or manually by a call to `RotateSecret`. |
| rotation_rules | A structure that defines the rotation configuration for the secret. |
| last_rotated_dates | The most recent date and time that the Secrets Manager rotation process was successfully completed. This value is `null` if the secret hasn't ever rotated. |
| last_changed_dates | The last date and time that this secret was modified in any way. |
| last_accessed_dates | The last date that this secret was accessed. This value is truncated to midnight of the date and therefore shows only the date, not the time. |
| deleted_dates | The date and time the deletion of the secret occurred. Not present on active secrets. The secret can be recovered until the number of days in the recovery window has passed, as specified in the `RecoveryWindowInDays` parameter of the `DeleteSecret` operation. |
| tags | The list of user-defined tags associated with the secret. |
| secret_versions_to_stages | A list of all of the currently assigned `SecretVersionStage` staging labels and the `SecretVersionId` attached to each one. Staging labels are used to keep track of the different versions during the rotation process. |
| owning_services | Returns the name of the service that created the secret. |
| created_dates | The date and time when a secret was created. |
| primary_regions | The region where Secrets Manager originated the secret. |

## Examples

### Ensure an ARN is available.

    describe aws_secretsmanager_secrets do
      its('arns') { should include 'SECRETS_MANAGER_SECRET_ARN' }
    end

### Ensure a name is available.

    describe aws_secretsmanager_secrets do
        its('names') { should include 'SECRET_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_secretsmanager_secrets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_secretsmanager_secrets do
      it { should_not exist }
    end

### be_available

Use `should` to check if the secret is available.

    describe aws_secretsmanager_secrets do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SecretsManager:Client:ListSecretsResponse` action with `Effect` set to `Allow`.
