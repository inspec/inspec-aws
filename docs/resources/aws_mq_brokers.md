---
title: About the aws_mq_brokers resource
platform: aws
---

# aws\_mq\_brokers

Use the `aws_mq_brokers` InSpec audit resource to test the properties of multiple AWS MQ Broker.

## Syntax

Ensure that AWS MQ Broker exists.

    describe aws_mq_brokers do
      it { should exist }
    end

For additional information, see the [AWS documentation on AWS MQ Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html).

## Properties

| Property | Description| Field|
| --- | --- | --- |
| broker_arns | The broker's Amazon Resource Name (ARN). | broker_arn |
| broker_names | The broker's name.| broker_name |
| broker_states | The broker's status.| broker_state |
| created | The time when the broker was created. | created |
| deployment_modes | The broker's deployment mode.| deployment_mode |
| engine_types | The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and RABBITMQ. | engine_type |
| engine_versions | The broker engine's version.  | engine_version |
| host_instance_types | The broker's instance type. | host_instance_type |

## Examples

### Ensure a broker is available.

    describe aws_mq_brokers do
      its('broker_ids') { should include 'broker_id' }
    end

### Ensure that the status is correct.

    describe aws_mq_brokers do
        its('broker_names') { should include 'broker_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_mq_brokers do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_mq_brokers do
      it { should_not exist }
    end

### be_available

Use `should` to check if the AWS MQ broker is available.

    describe aws_mq_brokers do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `MQ:Client:ListBrokersResponse` action with `Effect` set to `Allow`.
