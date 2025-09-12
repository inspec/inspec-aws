+++
title = "aws_secretsmanager_secrets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_secretsmanager_secrets"
identifier = "inspec/resources/aws/aws_secretsmanager_secrets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_secretsmanager_secrets` InSpec audit resource to test properties of multiple AWS Secret Manager secrets.

The `AWS::SecretsManager::Secret` resource creates a secret and stores it in Secrets Manager.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Secret Manager Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html).

## Syntax

Ensure that a secret exists.

```ruby
describe aws_secretsmanager_secrets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The Amazon Resource Name (ARN) of the secret.

`names`
: The friendly name of the secret.

`descriptions`
: The user-provided description of the secret.

`kms_key_ids`
: The ARN or alias of the AWS KMS customer master key (CMK) used to encrypt the `SecretString` and `SecretBinary` fields in each version of the secret.

`rotation_enabled`
: Indicates whether automatic, scheduled rotation is enabled for this secret.

`rotation_lambda_arns`
: The ARN of an AWS Lambda function invoked by Secrets Manager to rotate and expire the secret either automatically per the schedule or manually by a call to `RotateSecret`.

`rotation_rules`
: A structure that defines the rotation configuration for the secret.

`last_rotated_dates`
: The most recent date and time that the Secrets Manager rotation process was successfully completed. This value is `null` if the secret hasn't ever rotated.

`last_changed_dates`
: The last date and time that this secret was modified in any way.

`last_accessed_dates`
: The last date that this secret was accessed. This value is truncated to midnight of the date and therefore shows only the date, not the time.

`deleted_dates`
: The date and time the deletion of the secret occurred. Not present on active secrets. The secret can be recovered until the number of days in the recovery window has passed, as specified in the `RecoveryWindowInDays` parameter of the `DeleteSecret` operation.

`tags`
: The list of user-defined tags associated with the secret.

`secret_versions_to_stages`
: A list of all of the currently assigned `SecretVersionStage` staging labels and the `SecretVersionId` attached to each one. Staging labels are used to keep track of the different versions during the rotation process.

`owning_services`
: Returns the name of the service that created the secret.

`created_dates`
: The date and time when a secret was created.

`primary_regions`
: The region where Secrets Manager originated the secret.

## Examples

**Ensure an ARN is available.**

```ruby
describe aws_secretsmanager_secrets do
  its('arns') { should include 'SECRETS_MANAGER_SECRET_ARN' }
end
```

**Ensure a name is available.**

```ruby
describe aws_secretsmanager_secrets do
    its('names') { should include 'SECRET_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_secretsmanager_secrets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_secretsmanager_secrets do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the secret is available.

```ruby
describe aws_secretsmanager_secrets do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SecretsManager:Client:ListSecretsResponse" %}}
