---
title: About the aws_mq_broker resource
platform: aws
---

# aws\_mq\_broker

Use the `aws_mq_broker` InSpec audit resource to test the properties of a single specific AWS MQ Broker.

## Syntax

Ensure that AWS MQ Broker exists.

    describe aws_mq_broker(broker_id: 'broker_id') do
      it { should exist }
    end

## Parameters

`broker_id` _(required)_

| Property | Description|
| --- | --- |
| broker_id | The broker_id. | 

The broker_id.

For additional information, see the [AWS documentation on AWS MQ Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html).

## Properties

| Property | Description| Field |
| --- | --- | --- |
| authentication_strategy | The authentication strategy used to secure the broker. The default is SIMPLE. | authentication_strategy |
| auto_minor_version_upgrade | Enables automatic upgrades to new minor versions for brokers, as new versions are released and supported by Amazon MQ. | auto_minor_version_upgrade |
| broker_arn | The broker's Amazon Resource Name (ARN). | broker_arn |
| broker_name | The broker's name.| broker_name |
| broker_state | The broker's status.| broker_state |
| created | The time when the broker was created. | created |
| deployment_mode | The broker's deployment mode.| deployment_mode |
| engine_type | The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and RABBITMQ. | engine_type |
| engine_version | The broker engine's version.  | engine_version |
| host_instance_type | The broker's instance type. | host_instance_type |
| pending_engine_version | The broker engine version to upgrade to.  | pending_engine_version |
| pending_host_instance_type | The broker's host instance type to upgrade to. For a list of supported instance types. | pending_host_instance_type |
| publicly_accessible | Enables connections from applications outside of the VPC that hosts the broker's subnets. | publicly_accessible |
| storage_type | The broker's storage type. | storage_type |
| subnet_ids | The list of groups that define which subnets and IP ranges the broker can use from different | subnet_ids |
| tags | The list of all tags associated with this broker. | tags |

## Examples

### Ensure a broker id is available.

    describe aws_mq_broker(broker_id: 'broker_id') do
      its('broker_id') { should eq 'broker_id' }
    end

### Ensure a broker name is available..

    describe aws_mq_broker(broker_id: 'broker_id') do
        its('broker_name') { should eq 'broker_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_mq_broker(broker_id: 'broker_id') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_mq_broker(broker_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the mq broker is available.

    describe aws_mq_broker(broker_id: 'broker_id') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `MQ:Client:DescribeBrokerResponse` action with `Effect` set to `Allow`.
