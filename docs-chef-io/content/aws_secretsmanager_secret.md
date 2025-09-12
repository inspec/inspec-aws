+++
title = "aws_secretsmanager_secret resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_secretsmanager_secret"
identifier = "inspec/resources/aws/aws_secretsmanager_secret resource"
parent = "inspec/resources/aws"
+++

Use the `aws_secretsmanager_secret` InSpec audit resource to test properties of a single AWS Secret Manager secret.

The `AWS::SecretsManager::Secret` resource creates a secret and stores it in Secrets Manager.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Secret Manager Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html).

## Syntax

Ensure that a secret ID exists.

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
  it { should exist }
end
```

## Parameters

`secret_id` _(required)_

## Properties

`arn`
: The Amazon Resource Name (ARN) of the secret.

`name`
: The friendly name of the secret.

`description`
: The user-provided description of the secret.

`kms_key_id`
: The ARN or alias of the AWS KMS customer master key (CMK) used to encrypt the `SecretString` and `SecretBinary` fields in each version of the secret.

`rotation_enabled`
: Indicates whether automatic, scheduled rotation is enabled for this secret.

`rotation_lambda_arn`
: The ARN of an AWS Lambda function invoked by Secrets Manager to rotate and expire the secret either automatically per the schedule or manually by a call to `RotateSecret`.

`rotation_rules (automatically_after_days)`
: Specifies the number of days between automatic scheduled rotations of the secret.

`last_rotated_date`
: The most recent date and time that the Secrets Manager rotation process was successfully completed. This value is `null` if the secret hasn't ever rotated.

`last_changed_date`
: The last date and time that this secret was modified in any way.

`last_accessed_date`
: The last date that this secret was accessed. This value is truncated to midnight of the date and therefore shows only the date, not the time.

`deleted_date`
: The date and time the deletion of the secret occurred. Not present on active secrets. The secret can be recovered until the number of days in the recovery window has passed, as specified in the `RecoveryWindowInDays` parameter of the `DeleteSecret` operation.

`tags`
: The list of user-defined tags associated with the secret.

`secret_versions_to_stages`
: A list of all of the currently assigned `SecretVersionStage` staging labels and the `SecretVersionId` attached to each one. Staging labels are used to keep track of the different versions during the rotation process.

`owning_service`
: Returns the name of the service that created the secret.

`created_date`
: The date and time when a secret was created.

`primary_region`
: The region where Secrets Manager originated the secret.

## Examples

**Ensure the ARN is available.**

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
  its('arn') { should eq 'arn:aws:secretsmanager:us-west-2:123456789012:secret:MyTestDatabaseSecret-a1b2c3' }
end
```

**Ensure the name is available.**

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
    its('name') { should eq 'MyTestDatabaseSecret' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the secret ID is available.

```ruby
describe aws_secretsmanager_secret(secret_id: 'SECRET_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SecretsManager:Client:DescribeSecretResponse" %}}
