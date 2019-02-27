---
title: About the aws_iam_saml_provider Resource
platform: aws
---

# aws\_iam\_saml\_provider

Use the `aws_iam_saml_provider` InSpec audit resource to test properties of an AWS IAM SAML Provider.

<br>

## Syntax

An `aws_iam_saml_provider` resource block declares the tests for a single AWS IAM SAML Provider by Provider ARN.

    describe aws_iam_saml_provider('arn:aws:iam::123456789012:saml-provider/FANCY') do
        it { should exist }
    end

<br>