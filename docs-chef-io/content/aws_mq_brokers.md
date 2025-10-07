+++
title = "aws_mq_brokers resource"

draft = false


[menu.aws]
title = "aws_mq_brokers"
identifier = "inspec/resources/aws/aws_mq_brokers resource"
parent = "inspec/resources/aws"
+++

Use the `aws_mq_brokers` InSpec audit resource to test the properties of multiple AWS MQ Broker.

## Syntax

Ensure that AWS MQ Broker exists.

```ruby
describe aws_mq_brokers do
  it { should exist }
end
```

For additional information, see the [AWS documentation on AWS MQ Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html).

## Parameters

This resource does not require any parameters.

## Properties

`broker_arns`
: The broker's Amazon Resource Name (ARN).

: **Field**: `broker_arn`

`broker_names`
: The name of the broker. This value must be unique in your AWS account, 1-50 characters long, contain only letters, numbers, dashes, and underscores, and not contain white spaces, brackets, wildcard characters, or special characters.

: **Field**: `broker_name`

`broker_states`
: The broker's status.

: **Field**: `broker_state`

`created`
: Creation time of the broker profile.

: **Field**: `created`

`deployment_modes`
: The deployment mode of the broker. Available values: `SINGLE_INSTANCE`', `ACTIVE_STANDBY_MULTI_AZ`, and `CLUSTER_MULTI_AZ`.

: **Field**: `deployment_mode`

`engine_types`
: The type of broker engine. Currently, Amazon MQ supports `ACTIVEMQ` and `RABBITMQ.`.

: **Field**: `engine_type`

`engine_versions`
: The version of the broker engine.

: **Field**: `engine_version`

`host_instance_types`
: The broker's instance type.

: **Field**: `host_instance_type`

## Examples

Ensure a broker is available:

```ruby
describe aws_mq_brokers do
  its('broker_ids') { should include 'BROKER_ID' }
end
```

Ensure that the status is correct:

```ruby
describe aws_mq_brokers do
    its('broker_names') { should include 'BROKER_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_mq_brokers do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_mq_brokers do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the AWS MQ broker is available.

```ruby
describe aws_mq_brokers do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="MQ:Client:ListBrokersResponse" %}}
