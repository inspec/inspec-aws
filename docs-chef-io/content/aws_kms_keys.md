+++
title = "aws_kms_keys resource"

draft = false


[menu.aws]
title = "aws_kms_keys"
identifier = "inspec/resources/aws/aws_kms_keys resource"
parent = "inspec/resources/aws"
+++

Use the `aws_kms_keys` InSpec audit resource to test properties of some or all AWS KMS Keys.

AWS Key Management Service (KMS) is a managed service that makes creating and controlling your encryption keys for your data easier. KMS uses Hardware Security Modules (HSMs) to protect the security of your keys.

AWS Key Management Service is integrated with several other AWS services to help you protect the data you store with these services.

For additional information, including details on parameters and properties, see the [AWS documentation on KS Keys](https://docs.aws.amazon.com/kms/latest/developerguide/getting-started.html).

## Syntax

An `aws_kms_keys` resource block uses an optional filter to select a group of KMS Keys and then tests that group.

Verify the number of KMS keys in the AWS account:

```ruby
describe aws_kms_keys do
  its('entries.count') { should cmp 10 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`key_ids`
: The IDs of the returned keys.

`key_arns`
: The Amazon Resource Names of the returned keys.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

The following examples show how to use this InSpec audit resource.

Ensure a Key exists:

```ruby
describe aws_kms_keys do
  its('key_ids') { should include 'fd7e608b-f435-4186-b8b5-111111111111'}
end
```

Allow at most 100 KMS Keys on the account:

```ruby
describe aws_kms_keys do
  its('entries.count') { should be <= 100}
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_kms_keys do
  it { should exist }
end
```

```ruby
describe aws_kms_keys.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="KMS:Client:ListKeysResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS Key Management Service](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awskeymanagementservice.html).
