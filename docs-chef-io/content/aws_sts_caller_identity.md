+++
title = "aws_sts_caller_identity resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sts_caller_identity"
identifier = "inspec/resources/aws/aws_sts_caller_identity resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sts_caller_identity` InSpec audit resource to test properties of AWS IAM identity whose credentials are used in the current InSpec scan.

## Syntax

An `aws_sts_caller_identity` resource block may be used to perform tests on details of the AWS credentials being used in the current Inspec scan. You can also test if the credentials belong to a GovCloud account or not.

```ruby
describe aws_sts_caller_identity do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: This resource does not expect any parameters.

## Properties

`arn`
: The AWS ARN associated with the calling entity.

`account`
: The AWS account ID number of the account that owns or contains the calling entity.

`user_id`
: The unique identifier of the calling entity.

For more info, see [the API reference documentation](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity.html)

## Examples

Check that the credentials used to run the scan is correct:

```ruby
describe aws_sts_caller_identity do
  its("arn") { should match "arn:aws:iam::.*:user/service-account-inspec" }
end
```

Test if the account belongs to GovCloud:

```ruby
describe aws_sts_caller_identity do
  it { should be_govcloud }
end
```

Skip a test if we are using GovCloud:

```ruby
if aws_sts_caller_identity.govcloud?
  describe 'Skipping Root User MFA check as we are on GovCloud' do
    skip
  end
else
  describe aws_iam_root_user do
    it { should have_mfa_enabled }  
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_govcloud

The `be_govcloud` matcher tests if the account is a 'GovCloud' AWS Account.

```ruby
describe aws_sts_caller_identity do
    it { should_not be_govcloud }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="STS:Client:GetCallerIdentityResponse" %}}
