+++
title = "aws_mq_configurations Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_mq_configurations"
identifier = "inspec/resources/aws/aws_mq_configurations Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_mq_configurations` InSpec audit resource to test the properties of multiple AWS MQ configuration.

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that AWS MQ configuration exists.

```ruby
describe aws_mq_configurations do
  it { should exist }
end
```

For additional information, see the [AWS documentation on AWS MQ configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-configuration.html).

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The ARN of the configuration.

: **Field**: `arn`

`authentication_strategies`
: The authentication strategy associated with the configuration. The default is SIMPLE.

: **Field**: `authentication_strategy`

`Created`
: The date and time of the configuration revision.

: **Field**: `Created`

`description`
: The description of the configuration.

: **Field**: `description`

`engine_types`
: The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and RABBITMQ.

: **Field**: `engine_type`

`engine_versions`
: The broker engine's version. For a list of supported engine versions.

: **Field**: `engine_version`

`ids`
: The unique ID that Amazon MQ generates for the configuration.

: **Field**: `id`

`names`
: The name of the configuration.

: **Field**: `name`

`tags`
: The list of all tags associated with this configuration.

: **Field**: `tags`

## Examples

**Ensure a configuration ID is available.**

```ruby
describe aws_mq_configurations do
  its('ids') { should include 'configuration_id' }
end
```

**Ensure a configuration name is available.**

```ruby
describe aws_mq_configurations do
    its('names') { should include 'configuration_name' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_mq_configurations do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_mq_configurations do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the mq configuration is available.

```ruby
describe aws_mq_configurations do
  it { should be_available }
end
```

## AWS Permissions

{{% aws_permissions_principal action="MQ:Client:ListConfigurationsResponsegit" %}}
