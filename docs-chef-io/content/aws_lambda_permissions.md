+++
title = "aws_lambda_permissions resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_permissions"
identifier = "inspec/resources/aws/aws_lambda_permissions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_permissions` InSpec audit resource to test properties of multiple AWS Lambda permissions.

The `AWS::Lambda::Permission` resource grants an AWS service or another account permission to use a function. You can apply the policy at the function level, or specify a qualifier to restrict access to a single version or alias. If you use a qualifier, the invoker must use the full Amazon Resource Name (ARN) of that version or alias to invoke the function.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html).

## Syntax

Ensure that permission has the desired statement id.

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
  its('sids') { should include 'STATEMENT_ID' }
end
```

## Parameters

`function_name` _(required)_

## Properties

`sids`
: The statement ID of the function.

`effects`
: The effect of the function.

`principals`
: The AWS services or accounts that invokes the function.

`actions`
: The action of the function.

`resources`
: The resource ARNs of the function..

## Examples

**Ensure a statement ID is available.**

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
  its('sids') { should include 'STATEMENT_ID' }
end
```

**Ensure an effect is available.**

```ruby
describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
    its('effects') { should include 'Allow' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:GetPolicyResponse" %}}
