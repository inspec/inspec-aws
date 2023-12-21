+++
title = "aws_lambda_permission Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_lambda_permission"
identifier = "inspec/resources/aws/aws_lambda_permission Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_permission` InSpec audit resource to test properties of a single AWS Lambda permission.

The `AWS::Lambda::Permission` resource grants an AWS service or another account permission to use a function. You can apply the policy at the function level, or specify a qualifier to restrict access to a single version or alias. If you use a qualifier, the invoker must use the full Amazon Resource Name (ARN) of that version or alias to invoke the function.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that permission has the desired statement ID.

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME', Sid: 'STATEMENT_ID') do
  its('sid') { should eq 'STATEMENT_ID' }
end
```

## Parameters

`function_name` _(required)_

: The name of the Lambda function.

`Sid` _(required)_

: The statement ID of the function.

## Properties

`sid`
: The statement ID of the function.

`effect`
: The effect of the function.

`principal`
: The AWS service or account that invokes the function.

`action`
: The action that the principal can use on the function.

`resource`
: The resource ARN of the function.

## Examples

**Ensure a statement ID is available.**

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME', Sid: 'STATEMENT_ID') do
  its('sid') { should eq 'StatementID' }
end
```

**Ensure a effect is available.**

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME', Sid: 'STATEMENT_ID') do
    its('effect') { should eq 'Allow' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}



## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:GetPolicyResponse" %}}
