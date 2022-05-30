+++
title = "aws_api_gateway_usage_plan_keys resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_usage_plan_keys"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plan_keys resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plan_keys` InSpec audit resource to test the properties of multiple AWS APIGateway UsagePlanKey.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlanKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplankey.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the usage plan key exists.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

## Parameters

`usage_plan_id` _(required)_

: The Id of the UsagePlan resource representing the usage plan containing the to-be-retrieved UsagePlanKey resource representing a plan customer.

## Properties

`ids`
: The Id of a usage plan key.

: **Field**: `id`

`types`
: The type of a usage plan key. Currently, the valid key type is API_KEY.

: **Field**: `type`

`values`
: The value of a usage plan key.

: **Field**: `value`

`names`
: The name of a usage plan key.

: **Field**: `name`

## Examples

**Ensure an usage plan key id is available.**

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  its('ids') { should include 'USAGE_PLAN_KEY_ID' }
end
```

**Ensure an usage plan key name is available.**

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  its('names') { should include 'USAGE_PLAN_KEY_NAME' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGateway:Client:UsagePlanKeys" %}}
