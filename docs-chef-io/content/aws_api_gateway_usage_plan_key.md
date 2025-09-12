+++
title = "aws_api_gateway_usage_plan_key resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_usage_plan_key"
identifier = "inspec/resources/aws/aws_api_gateway_usage_plan_key resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_usage_plan_key` InSpec audit resource to test the properties of a specific AWS API Gateway usage plan key.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGateway UsagePlanKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-usageplankey.html).

## Syntax

Ensure that a usage plan key exists.

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  it { should exist }
end
```

## Parameters

`usage_plan_id` _(required)_

: The usage plan resource ID represents the usage plan containing the to-be-retrieved usage plan's key resource and a plan customer.

`key_id` _(required)_

: The key ID of the to-be-retrieved usage plan key resource representing a plan customer.

## Properties

`id`
: The usage plan key ID.

`type`
: The usage plan key type. Currently, the valid key type is `API_KEY`.

`value`
: The value of a usage plan key.

`name`
: The usage plan key name.

## Examples

### Test to ensure a usage plan key ID is available

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  its('id') { should eq 'USAGE_PLAN_KEY_ID' }
end
```

### Test to ensure a usage plan key name is available

```ruby
describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
  its('name') { should eq 'USAGE_PLAN_KEY_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:UsagePlanKey" %}}
