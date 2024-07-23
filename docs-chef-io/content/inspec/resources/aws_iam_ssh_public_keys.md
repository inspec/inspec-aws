+++
title = "aws_iam_ssh_public_keys Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_ssh_public_keys"
identifier = "inspec/resources/aws/aws_iam_ssh_public_keys Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_ssh_public_keys` InSpec audit resource to test the properties of the plural resource of an AWS SSH public key for an IAM user.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS IAM AccessKey.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the public key exists by passing the parameter user_name.

```ruby
describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
  it { should exist }
end
```

Ensure that the public key exists without passing any parameter.

```ruby
describe aws_iam_ssh_public_keys do
  it { should exist }
end
```

## Parameters

`user_name` _(required)_ 

: The IAM user name associated with the SSH public key. The above required parameter is optional.

## Properties

`user_names`
: The IAM user name associated with the SSH public key.

: **Field**: `user_name`

`ssh_public_key_ids`
: The unique identifier for the SSH public key.

: **Field**: `ssh_public_key_id`

`statuses`
: The status of the SSH public key.

: **Field**: `status`

`upload_dates`
: The date and time, in ISO 8601 date-time format, when the SSH public key is uploaded.

: **Field**: `upload_date`

## Examples

**Ensure a user name is available.**

```ruby
describe aws_iam_ssh_public_keys do
  its('user_names') { should include 'USER_NAME' }
end
```

**Ensure an ssh public key id is available.**

```ruby
describe aws_iam_ssh_public_keys do
    its('ssh_public_key_ids') { should include 'KEY_ID' }
end
```

**Ensure status is 'Active' by passing the parameter user_name.**

```ruby
describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
    its('statuses') { should include 'Active' }
end
```

**Ensure status is 'Active' without passing any parameter.**

```ruby
describe aws_iam_ssh_public_keys do
    its('statuses') { should include 'Active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
  it { should exist }
end
```

```ruby
describe aws_iam_ssh_public_keys do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
  it { should_not exist }
end
```

```ruby
describe aws_iam_ssh_public_keys do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
  it { should be_available }
end
```

```ruby
describe aws_iam_ssh_public_keys do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListSSHPublicKeysResponse" %}}
