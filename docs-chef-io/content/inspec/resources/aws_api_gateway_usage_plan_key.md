+++
title = "aws_api_gateway_usage_plan_key resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_usage_plan_key"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plan_key resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plan_key` InSpec audit resource to test the properties of a single specific AWS APIGateway UsagePlanKey.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlanKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplankey.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that an usage plan key exists.

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  it { should exist }
end
```

## Parameters

`usage_plan_id` _(required)_

: The Id of the UsagePlan resource representing the usage plan containing the to-be-retrieved UsagePlanKey resource representing a plan customer.

`key_id` _(required)_

: The key Id of the to-be-retrieved UsagePlanKey resource representing a plan customer.

## Properties

`id`
: The Id of a usage plan key.

`type`
: The type of a usage plan key. Currently, the valid key type is API_KEY.

`value`
: The value of a usage plan key.

`name`
: The name of a usage plan key.

## Examples

**Ensure an usage plan key id is available.**

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  its('id') { should eq 'USAGE_PLAN_KEY_ID' }
end
```

**Ensure an usage plan key name is available.**

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  its('name') { should eq 'USAGE_PLAN_KEY_NAME' }
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

{{% aws_permissions_principal action="APIGateway:Client:UsagePlanKey" %}}
