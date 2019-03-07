---
title: About the aws_iam_saml_providers Resource
platform: aws
---

# aws\_iam\_saml\_providers

Use the `aws_iam_saml_providers` InSpec audit resource to test properties of some or all AWS IAM SAML Providers.


<br>

## Syntax

An `aws_iam_saml_providers` resource block returns all IAM SAML Providers and allows the testing of that group of Providers.

    describe aws_iam_saml_providers do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this Inspec audit resource.

    # Ensure we have at least one provider currently valid
      describe.one do
        aws_iam_saml_providers.provider_arns.each do |provider_arn|
          describe aws_iam_saml_provider(provider_arn) do
            it { should exist }
            its('arn') { should match("arn:aws:iam::.*:saml-provider\/FANCY") }
            its('valid_until') { should be > Time.now + 90 * 86400 }
          end
        end
      end

    # Ensure we have one and only one SAML provider
      describe aws_iam_saml_providers do
        its('entries.count') { should cmp 1 }
      end

    # Ensure we have at least one provider that matches
      describe aws_iam_saml_providers.where{ arn =~ /arn:aws:iam::.*:saml-provider\/FANCY/ } do
        it { should exist }
      end

<br>

## Properties

* arn
* valid_until

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the filtered IAM SAML Provider(s) exists.

      describe aws_iam_saml_providers.where( <property>: <param>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions set to Allow:
`iam:ListSamlProviders`
`iam:GetSamlProvider`
