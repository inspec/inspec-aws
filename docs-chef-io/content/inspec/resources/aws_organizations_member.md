+++
title = "aws_organizations_member Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_organizations_member"
identifier = "inspec/resources/aws/aws_organizations_member Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_organizations_member` InSpec audit resource to test the current AWS Account being used within an organization.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_organizations_member` resource block tests if the current AWS Account is the Master Account.

The `master` matcher will return `true` or `false` accordingly.
You may also verify that the `master_account_id` and `master_account_arn` properties match known values.

If the current AWS Account _**is**_ the Master Account, you may also access properties of that account.

```ruby
describe aws_organizations_member do
    it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`master_account_id`
: The ID of the AWS Organizations Master Account.

`master_account_arn`
: The ARN of the AWS Organizations Master Account.

_**If the current Account is the Master Account, the following properties are also available:**_

|Property             | Description|
| ---                 | --- |
|account_id          | The ID of the current Account. |
|account_arn         | The ARN of the current Account.  |
|account_name        | The Name of the current Acccount. |
|account_email       | The Email address associated with the current Account.  |

## Examples

**Ensure you are a child account with a certain ID for the top level account.**

```ruby
describe aws_organizations_member do
  it                       { should_not be_master }
  its('master_account_id') { should cmp '56845218745' }
end
```

**Ensure you are the top level account, with the right name and email associated.**

```ruby
describe aws_organizations_member do
  it                   { should be_master }
  its('account_name')  { should eq 'MyAWSMasterAccount' }
  its('account_email') { should eq 'aws.admin@org.com' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_master

The `be_master` matcher tests if the account is a 'master' AWS Account.

```ruby
it { should_not be_master }
```

### exist

The control will pass if the describe returns at least one result.

```ruby
it { should exist }
```