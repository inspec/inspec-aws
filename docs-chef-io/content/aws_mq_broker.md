+++
title = "aws_mq_broker resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_mq_broker"
identifier = "inspec/resources/aws/aws_mq_broker resource"
parent = "inspec/resources/aws"
+++

Use the `aws_mq_broker` InSpec audit resource to test the properties of a single specific AWS MQ Broker.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS MQ Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html).

## Syntax

Ensure that AWS MQ Broker exists.

```ruby
describe aws_mq_broker(broker_id: 'BROKER_ID') do
  it { should exist }
end
```

## Parameters

`broker_id` _(required)_

: broker_id: The ID of the AWS MQ broker.

## Properties

`authentication_strategy`
: The authentication strategy used to secure the broker. The default is `SIMPLE`.

: **Field**: `authentication_strategy`

`auto_minor_version_upgrade`
: Enables automatic upgrades to new minor versions for brokers, as new versions are released and supported by Amazon MQ.

: **Field**: `auto_minor_version_upgrade`

`broker_arn`
: The broker's Amazon Resource Name (ARN).

: **Field**: `broker_arn`

`broker_name`
: The name of the broker.

: **Field**: `broker_name`

`broker_state`
: The broker's status.

: **Field**: `broker_state`

`created`
: Creation time of the broker's profile.

: **Field**: `created`

`deployment_mode`
: The deployment mode of the broker.

: **Field**: `deployment_mode`

`engine_type`
: The type of broker engine. Currently, Amazon MQ supports `ACTIVEMQ` and `RABBITMQ.`.

: **Field**: `engine_type`

`engine_version`
: The version of the broker engine.

: **Field**: `engine_version`

`host_instance_type`
: The broker's instance type.

: **Field**: `host_instance_type`

`pending_engine_version`
: The broker engine version for the upgrade.

: **Field**: `pending_engine_version`

`pending_host_instance_type`
: The broker's host instance type for the upgrade.

: **Field**: `pending_host_instance_type`

`publicly_accessible`
: Enables connections from applications outside of the VPC that hosts the broker's subnets.

: **Field**: `publicly_accessible`

`storage_type`
: The broker's storage type.

: **Field**: `storage_type`

`subnet_ids`
: The list of groups defines which subnets and IP range the broker can use from different availability zones. If you specify more than one subnet, the subnets must be in different availability zones. Amazon MQ cannot create VPC endpoints for the broker with multiple subnets in the same availability zone. A `SINGLE_INSTANCE` deployment requires one subnet (for example, the default subnet). An `ACTIVE_STANDBY_MULTI_AZ deployment (ACTIVEMQ)` requires two subnets. A `CLUSTER_MULTI_AZ deployment (RABBITMQ)` has no subnet requirements when deployed with public accessibility, deployment without public accessibility requires at least one subnet.

: **Field**: `subnet_ids`

`tags`
: The list of all tags associated with this broker.

: **Field**: `tags`

## Examples

Ensure a broker ID is available:

```ruby
describe aws_mq_broker(broker_id: 'BROKER_ID') do
  its('broker_id') { should eq 'BROKER_ID }
end
```

Ensure a broker name is available:

```ruby
describe aws_mq_broker(broker_id: 'BROKER_ID') do
    its('broker_name') { should eq 'BROKER_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_mq_broker(broker_id: 'BROKER_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_mq_broker(broker_id: 'DUMMY') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the mq broker is available.

```ruby
describe aws_mq_broker(broker_id: 'BROKER_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="MQ:Client:DescribeBrokerResponse" %}}
