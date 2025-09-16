+++
title = "aws_lambdas resource"

draft = false


[menu.aws]
title = "aws_lambdas"
identifier = "inspec/resources/aws/aws_lambdas resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambdas` resource to test the collection of lambdas deployed into an account.

## Syntax

````
describe aws_lambdas do
    its('count') { should eq 20 }
end
````

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The names of the lambda deployed.

`tags`
: The tags of the lambda deployed.

## Examples

Tests that all lambdas with a particular tag is correctly deployed:

````
lambdas = aws_lambdas()

describe lambdas do
its ('count') { should eq 33}
end

lambdas.tags.each_with_index { | tag, i |
if tag!= {} and tag.include? 'Application' and tag['Application']=='test')
    lambda_name = lambdas.names[i]

    describe aws_lambda(lambda_name) do
        it { should exist}
        its ('handler') { should eq 'main.on_event'}
        its ('version') { should eq '$LATEST' }
        its ('runtime') { should eq 'python3.7' }
    end
end
}
````

## Matchers

This InSpec audit resource uses the standard matchers. For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListFunctionsResponse" %}}

You can find detailed documentation at [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-api-permissions-ref.html)
