+++
title = "aws_iam_saml_provider resource"

draft = false


[menu.aws]
title = "aws_iam_saml_provider"
identifier = "inspec/resources/aws/aws_iam_saml_provider resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_saml_provider` InSpec audit resource to test properties of an AWS IAM SAML Provider.

## Syntax

```ruby
describe aws_iam_saml_provider('SAML_ARN') do
    it { should exist }
end
```

## Parameters

`saml_provider_arn` _(required)_

: This resource accepts a single parameter, the ARN of the SAML Provider.
  This can be passed either as a string or as a `saml_provider_arn: 'value'` key-value entry in a hash.

## Properties

`provider`
: The provider.

`arn`
: The arn of the provider.

`saml_metadata_document`
: Metadata document associated with the saml provider.

`valid_until`
: The expiration date and time for the SAML provider.

`create_date`
: The date and time, in ISO 8601 date-time format , when the role was created.

## Syntax

An `aws_iam_saml_provider` resource block declares the tests for a single AWS IAM SAML Provider by Provider ARN.

```ruby
describe aws_iam_saml_provider('arn:aws:iam::123456789012:saml-provider/FANCY') do
    it { should exist }
end
```

## Examples

Ensure we have at least one provider currently valid:

```ruby
describe aws_iam_saml_provider("arn:aws:iam::123456789012:saml-provider/FANCY") do
  it { should exist }
  its("arn") { should match("arn:aws:iam::.*:saml-provider\/FANCY") }
  its("valid_until") { should be > Time.now + 90 * 86400 }
    end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The `exists` matcher tests if the filtered IAM SAML Provider(s) exists.

```ruby
describe aws_iam_saml_provider('arn:aws:iam::123456789012:saml-provider/FANCY') do
  it { should exist }
end
```

You may also use `it { should_not exist }`.

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetSAMLProviderResponse" %}}
