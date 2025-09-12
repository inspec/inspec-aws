+++
title = "aws_iam_oidc_provider resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_oidc_provider"
identifier = "inspec/resources/aws/aws_iam_oidc_provider resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_oidc_provider` InSpec audit resource to test properties of a single IAM OpenID Connect (OIDC) provider.

This resource retrieves information about the specified OIDC provider.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM OIDC provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Syntax

Ensure that an OIDC provider exists.

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
  it { should exist }
end
```

## Parameters

`open_id_connect_provider_arn` _(required)_

: The Amazon Resource Name (ARN) of the OIDC provider resource object in IAM to get information for.

## Properties

`url`
: The URL that the IAM OIDC provider resource object is associated with.

`create_date`
: The date and time when the IAM OIDC provider resource object was created in the account.

`tags`
: A list of tags that are attached to the specified IAM OIDC provider.

## Examples

**Ensure an URL is available.**

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
  its('url') { should eq 'example.com' }
end
```

**Ensure that tags are available.**

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
    its('tags') { should eq ':TAG => 'TAG_VALUE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'OIDC_PROVIDER_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetOpenIDConnectProviderResponse" %}}
