+++
title = "aws_lambda resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda"
identifier = "inspec/resources/aws/aws_lambda resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda` resource to test a specific AWS Lambda function.

## Syntax

```ruby
describe aws_lambda('LAMBDA_FUNCTION') do
    it { should exist}
    its ('handler') { should eq 'main.on_event'}
    its ('version') { should eq '$LATEST' }
    its ('runtime') { should eq 'python3.7' }
end
```

## Parameters

This resource expects the name of the AWS Lambda function.

## Properties

This resource can test all properties defined by the [Aws::lambda::Types::GetFunctionResponse](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Lambda/Types/GetFunctionResponse.html) class.

## Examples

**Test that all lambda functions with a particular tag is correctly deployed.**

```ruby
describe aws_lambda('LAMBDA_FUNCTION') do
    it { should exist}
    its ('handler') { should eq 'main.on_event'}
    its ('version') { should eq '$LATEST' }
    its ('runtime') { should eq 'python3.7' }
end
```

## Matchers

This InSpec audit resource uses the standard matchers. For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:GetFunctionResponse" %}}

You can find detailed documentation at [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-api-permissions-ref.html)
