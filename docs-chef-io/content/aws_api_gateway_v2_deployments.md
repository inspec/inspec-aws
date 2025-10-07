+++
title = "aws_api_gateway_v2_deployments resource"

draft = false


[menu.aws]
title = "aws_api_gateway_v2_deployments"
identifier = "inspec/resources/aws/aws_api_gateway_v2_deployments resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_deployments` InSpec audit resource to test properties of multiple AWS API Gateway V2 deployments.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-deployment.html).

## Syntax

Ensure that the deployment exists.

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_

: The API identifier.

## Properties

`auto_deployeds`
: Specifies whether the deployment was automatically released.

: **Field**: `auto_deployed`

`created_dates`
: The date and time when the Deployment resource was created.

: **Field**: `created_date`

`deployment_ids`
: The identifier for the deployment.

: **Field**: `deployment_id`

`deployment_statuses`
: The status of the deployment: PENDING, FAILED, or SUCCEEDED.

: **Field**: `deployment_status`

`deployment_status_messages`
: May contain additional feedback on the status of an API deployment.

: **Field**: `deployment_status_message`

`descriptions`
: The description for the deployment.

: **Field**: `description`

## Examples

### Test to ensure a deployment ID is available

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  its('deployment_ids') { should include 'DEPLOYMENT_ID' }
end
```

### Test to verify the deployment status

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  its('deployment_statuses') { should include 'DEPLOYED' }
end
```

### Test to ensure an authorizer type has `JWT`

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  its('authorizer_types') { should include 'JWT' }
end
```

### Test to ensure a description is available

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  its('descriptions') { should include 'DEPLOYMENT_DESCRIPTION' }
end
```

### Test to ensure an auto-deployment is enabled for a deployment

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  its('auto_deployeds') { should include true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  it { should exist }
end
```

### not exists

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_deployments(api_id: 'APP_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetDeploymentsResponse" %}}
