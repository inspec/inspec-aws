+++
title = "aws_iam_saml_providers resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_saml_providers"
identifier = "inspec/resources/aws/aws_iam_saml_providers resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_saml_providers` InSpec audit resource to test properties of some or all AWS IAM SAML Providers.

## Syntax

An `aws_iam_saml_providers` resource block returns all IAM SAML Providers and allows the testing of that group of Providers.

```ruby
describe aws_iam_saml_providers do
  it { should exist }
end
```

## Parameters

`saml_provider_arn` _(required)_

: This resource accepts a single parameter, the ARN of the SAML Provider.
  This can be passed either as a string or as a `saml_provider_arn: 'value'` key-value entry in a hash.

## Properties

`provider_arns`
: The ARNs of the returned providers.

`valid_untils`
: The expiration date and time for the SAML provider.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

Ensure we have at least one provider currently valid:

```ruby
describe.one do
  aws_iam_saml_providers.provider_arns.each do |provider_arn|
    describe aws_iam_saml_provider(provider_arn) do
      it { should exist }
      its('arn') { should match("arn:aws:iam::.*:saml-provider\/FANCY") }
      its('valid_until') { should be > Time.now + 90 * 86400 }
    end
  end
end
```

Ensure we have one and only one SAML provider:

```ruby
describe aws_iam_saml_providers do
  its('entries.count') { should cmp 1 }
end
```

Ensure we have at least one provider that matches:

```ruby
describe aws_iam_saml_providers.where{ arn =~ /arn:aws:iam::.*:saml-provider\/FANCY/ } do
  it { should exist }
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The `exists` matcher tests if the filtered IAM SAML Provider(s) exists.

```ruby
describe aws_iam_saml_providers.where( <property>: <param>) do
  it { should exist }
end
```

You may also use `it { should_not exist }`.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions set to Allow:
`IAM:Client:ListSAMLProvidersResponse`
`IAM:Client:etSAMLProviderResponse`
