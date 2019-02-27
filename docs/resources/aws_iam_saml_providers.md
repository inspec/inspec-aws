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