---
title: About the aws_mq_configuration Resource
platform: aws
---

# aws\_mq\_configuration

Use the `aws_mq_configuration` InSpec audit resource to test the properties of a single specific AWS MQ configuration.

## Syntax

Ensure that AWS MQ configuration exists.

    describe aws_mq_configuration(configuration_id: 'configuration_id') do
      it { should exist }
    end

## Parameters

`configuration_id` _(required)_

| Property | Description |
| --- | --- |
| configuration_id | The configuration ID.|

For additional information, see the [AWS documentation on AWS MQ configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-configuration.html).

## Properties

| Property | Description| Field |
| --- | --- | --- |
| arn | The ARN of the configuration.| arn |
| authentication_strategy |  The authentication strategy associated with the configuration. The default is SIMPLE.| authentication_strategy |
| created | The date and time of the configuration revision. | Created |
| description | The description of the configuration. | description |
| engine_type | The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ and RABBITMQ. | engine_type |
| engine_version |  The broker engine's version. For a list of supported engine versions | engine_version |
| id | The unique ID that Amazon MQ generates for the configuration. | id |
| name |  The name of the configuration.  | name |
| tags | The list of all tags associated with this configuration. | tags |

## Examples

### Ensure a configuration id is available.

    describe aws_mq_configuration(configuration_id: 'configuration_id') do
      its('configuration_id') { should eq 'configuration_id' }
    end

### Ensure a configuration name is available.

    describe aws_mq_configuration(configuration_id: 'configuration_id') do
        its('configuration_name') { should eq 'configuration_name' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_mq_configuration(configuration_id: 'configuration_id') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_mq_configuration(configuration_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the mq configuration is available.

    describe aws_mq_configuration(configuration_id: 'configuration_id') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `MQ:Client:DescribeConfigurationResponse` action with `Effect` set to `Allow`.
