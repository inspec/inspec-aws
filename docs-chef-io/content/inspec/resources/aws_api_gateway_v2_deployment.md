+++
title = "aws_api_gateway_v2_deployment resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_deployment"
identifier = "inspec/resources/aws/aws_api_gateway_v2_deployment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_deployment` InSpec audit resource to test the properties of a specific AWS API Gateway V2 deployment.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-deployment.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the deployment exists.

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

`deployment_id` _(required)_
: The identifier for the deployment.

## Properties

`auto_deployed`
: Specifies whether a deployment was automatically released.

`created_date`
: The date and time when the Deployment resource was created.

`deployment_id`
: The identifier for the deployment.

`deployment_status`
: The status of the deployment. The valid values are `PENDING`, `FAILED`, or `SUCCEEDED`.

`deployment_status_message`
: May contain additional feedback on the status of an API deployment.

`description`
: The description for the deployment.

## Examples

### Test to ensure a deployment ID is available

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('deployment_id') { should eq 'DEPLOYMENT_ID' }
end
```

### Verify the deployment status

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('deployment_status') { should eq 'DEPLOYED' }
end
```

### Test to ensure a deployment ID is `JWT`

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('authorizer_type') { should eq 'JWT' }
end
```

### Test to ensure a description is available

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('description') { should eq 'DEPLOYMENT_DESCRIPTION' }
end
```

### Test to ensure a auto deployment is enabled

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  its('auto_deployed') { should eq true }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGatewayv2:Client:GetDeploymentResponse" %}}
