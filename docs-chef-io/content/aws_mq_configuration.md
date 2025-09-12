+++
title = "aws_mq_configuration resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_mq_configuration"
identifier = "inspec/resources/aws/aws_mq_configuration resource"
parent = "inspec/resources/aws"
+++

Use the `aws_mq_configuration` InSpec audit resource to test the properties of a single specific AWS MQ configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS MQ configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-configuration.html).

## Syntax

Ensure that AWS MQ configuration exists.

```ruby
describe aws_mq_configuration(configuration_id: 'configuration_id') do
  it { should exist }
end
```

## Parameters

`configuration_id` _(required)_

`configuration_id`
: The configuration ID.

## Properties

`arn`
: The ARN of the configuration.

: **Field**: `arn`

`authentication_strategy`
: The authentication strategy associated with the configuration. The default is SIMPLE.

: **Field**: `authentication_strategy`

`created`
: The date and time of the configuration revision.

: **Field**: `Created`

`description`
: The description of the configuration.

: **Field**: `description`

`engine_type`
: The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and RABBITMQ.

: **Field**: `engine_type`

`engine_version`
: The broker engine's version. For a list of supported engine versions.

: **Field**: `engine_version`

`id`
: The unique ID that Amazon MQ generates for the configuration.

: **Field**: `id`

`name`
: The name of the configuration.

: **Field**: `name`

`tags`
: The list of all tags associated with this configuration.

: **Field**: `tags`

## Examples

**Ensure a configuration id is available.**

```ruby
describe aws_mq_configuration(configuration_id: 'configuration_id') do
  its('configuration_id') { should eq 'configuration_id' }
end
```

**Ensure a configuration name is available.**

```ruby
describe aws_mq_configuration(configuration_id: 'configuration_id') do
    its('configuration_name') { should eq 'configuration_name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_mq_configuration(configuration_id: 'configuration_id') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_mq_configuration(configuration_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the mq configuration is available.

```ruby
describe aws_mq_configuration(configuration_id: 'configuration_id') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="MQ:Client:DescribeConfigurationResponse" %}}
