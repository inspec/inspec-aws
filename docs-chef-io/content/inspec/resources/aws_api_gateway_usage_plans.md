+++
title = "aws_api_gateway_usage_plans resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_usage_plans"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plans resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plans` InSpec audit resource to test the properties of multiple AWS API Gateway usage plans. A usage plan sets a target for the throttling and quota limits on individual client API keys.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlan](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplan.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the usage plan exists.

```ruby
describe aws_api_gateway_usage_plans do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The identifier of a usage plan resource.

: **Field**: `id`

`names`
: The name of a usage plan.

: **Field**: `name`

`descriptions`
: The description of a usage plan.

: **Field**: `description`

`api_stages`
: The associated API stages of a usage plan.

: **Field**: `api_stages`

`throttles`
: A map containing method level throttling information for the API stage in a usage plan.

: **Field**: `throttle`

`quotas`
: The maximum target number of permitted requests that the user can make within a given time interval

: **Field**: `quota`

`product_codes`
: The AWS Marketplace product identifier to associate with the usage plan as a SaaS product on AWS Marketplace.

: **Field**: `product_code`

`tags`
: The collection of tags. Each tag element is associated with a given resource.

: **Field**: `tags`

## Examples

### Test to ensure a usage plan ID is available

```ruby
describe aws_api_gateway_usage_plans do
  its('ids') { should include 'USAGE_PLAN_ID' }
end
```

### Test to ensure a usage plan name is available

```ruby
describe aws_api_gateway_usage_plans do
  its('names') { should include 'USAGE_PLAN_NAME' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_usage_plans do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_usage_plans do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:UsagePlans" %}}
