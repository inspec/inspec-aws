+++
title = "aws_api_gateway_usage_plan resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_usage_plan"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plan resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plan` InSpec audit resource to test the properties of a single specific AWS APIGateway UsagePlan.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlan](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplan.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that an usage plan exists.

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

## Parameters

`usage_plan_id` _(required)_

: The identifier of a UsagePlan resource.

## Properties

`id`
: The identifier of a UsagePlan resource.

: **Field**: `id`

`name`
: The name of a usage plan.

: **Field**: `name`

`description`
: The description of a usage plan.

: **Field**: `description`

`api_stages`
: The associated API stages of a usage plan.

: **Field**: `api_stages`

`api_stages_api_ids`
: API Id of the associated API stage in a usage plan.

: **Field**: `api_stages[0].api_id`

`api_stages_stages`
: API stage name of the associated API stage in a usage plan.

: **Field**: `api_stages[0].stage`

`api_stages_throttles`
: Map containing method level throttling information for API stage in a usage plan.

: **Field**: `api_stages[0].throttle`

`throttle`
: A map containing method level throttling information for API stage in a usage plan.

: **Field**: `throttle`

`throttle.burst_limit`
: The API target request burst rate limit. This allows more requests through for a period of time than the target rate limit.

: **Field**: `throttle.burst_limit`

`throttle.rate_limit`
: The API target request rate limit.

: **Field**: `throttle.rate_limit`

`quota`
: The target maximum number of permitted requests per a given unit time interval.

: **Field**: `quota`

`quota.limit`
: The target maximum number of requests that can be made in a given time period.

: **Field**: `quota.limit`

`quota.offset`
: The number of requests subtracted from the given limit in the initial time period.

: **Field**: `quota.offset`

`quota.period`
: The time period in which the limit applies. Valid values are "DAY", "WEEK" or "MONTH".

: **Field**: `quota.period`

`product_code`
: The AWS Markeplace product identifier to associate with the usage plan as a SaaS product on AWS Marketplace.

: **Field**: `product_code`

`tags`
: The collection of tags. Each tag element is associated with a given resource.

: **Field**: `tags`

## Examples

**Ensure an usage plan id is available.**

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  its('id') { should eq 'USAGE_PLAN_ID' }
end
```

**Ensure an usage plan name is available.**

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  its('name') { should eq 'USAGE_PLAN_NAME' }
end
```

**Verify the quota limit is set to `2` in the usage plan api gateway.**

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  its('quota.limit') { should eq 2 }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:UsagePlan" %}}
