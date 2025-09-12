+++
title = "aws_api_gateway_deployment resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_deployment"
identifier = "inspec/resources/aws/aws_api_gateway_deployment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_deployment` InSpec audit resource to test properties of a single AWS ApiGateway Deployment.

The AWS::ApiGateway::Deployment resource deploys an API Gateway RestApi resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

For additional information, including details on parameters and properties, see the [AWS ApiGateway Deployment documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment.html).

## Syntax

Ensure that the deployment exists.

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi.

`deployment_id` _(required)_

: The identifier of the deployment resource to get information about.

## Properties

`id`
: The identifier for the deployment resource.

`description`
: The description for the deployment resource.

`created_date`
: The date and time that the deployment resource was created.

`api_summary`
: A summary of the RestAPI at the date and time that the deployment resource was created.

`api_summary (authorization_type)`
: The method's authorization type. Valid values are `NONE` for open access, `AWS_IAM` for using AWS IAM permissions, `CUSTOM` for using a custom authorizer, or `COGNITO_USER_POOLS` for using a Cognito user pool.

`api_summary (api_key_required)`
: Specifies whether the method requires a valid ApiKey .

## Examples

**Ensure that the deployment ID exists.**

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('id') { should eq 'DEPLOYMENT_IDENTIFIER' }
end
```

**Check whether the API key is required for a particular deployment.**

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
    its('api_summary.api_key_required') { should eq false }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Deployment" %}}
