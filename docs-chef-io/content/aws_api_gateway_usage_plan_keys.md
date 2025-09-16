+++
title = "aws_api_gateway_usage_plan_keys resource"

draft = false


[menu.aws]
title = "aws_api_gateway_usage_plan_keys"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plan_keys resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plan_keys` InSpec audit resource to test the properties of multiple AWS API Gateway usage plan keys.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlanKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplankey.html).

## Syntax

Ensure that the usage plan key exists.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

## Parameters

`usage_plan_id` _(required)_

: The usage plan resource ID represents the usage plan containing the to-be-retrieved usage plan's key resource and a plan customer.

## Properties

`ids`
: The usage plan key ID.

: **Field**: `id`

`types`
: The usage plan key type. Currently, the valid key type is `API_KEY`.

: **Field**: `type`

`values`
: The usage plan key value.

: **Field**: `value`

`names`
: The usage plan key name.

: **Field**: `name`

## Examples

### Test to ensure a usage plan key ID is available

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  its('ids') { should include 'USAGE_PLAN_KEY_ID' }
end
```

### Test to ensure a usage plan key name is available

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  its('names') { should include 'USAGE_PLAN_KEY_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_usage_plan_keys(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:UsagePlanKeys" %}}
