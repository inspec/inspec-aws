+++
title = "aws_iam_oidc_providers resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_oidc_providers"
identifier = "inspec/resources/aws/aws_iam_oidc_providers resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_oidc_providers` InSpec audit resource to test properties of a set of AWS IAM OpenID Connect (OIDC) providers.

This resource retrieves information about all OIDC providers.

## Syntax

Ensure that an OIDC provider exists.

```ruby
describe aws_iam_oidc_providers do
  it { should exist }
end
```

For additional information, see the [AWS documentation on IAM OIDC provider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html).

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The Amazon Resource Name (ARN).

## Examples

**Ensure a OIDC Provider is available.**

```ruby
describe aws_iam_oidc_providers do
  its('arns') { should include 'OIDC_PROVIDER_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_oidc_providers do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_oidc_providers do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the OIDC Provider is available.

```ruby
describe aws_iam_oidc_providers do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListOpenIDConnectProviderTagsResponse" %}}
