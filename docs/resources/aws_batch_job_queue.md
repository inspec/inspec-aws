---
title: About the aws_batch_job_queue Resource
platform: aws
---

# aws\_batch\_job\_queue

Use the `aws_batch_job_queue` InSpec audit resource to test properties of a single specific Athena Work Group.

The AWS::Batch::JobQueue resource specifies the parameters for an AWS Batch Job Queue.

## Syntax

Ensure that a job_queue name exists.

    describe aws_batch_job_queue(job_queue_name: 'test1') do
      it { should exist }
    end

## Parameters

`job_queue_name` _(required)_

For additional information, see the [AWS documentation on Athena Work Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html).

## Properties

| Property | Description|
| --- | --- |
| job_definition_name | The name of the job queue. |
| job_definition_arn | The arn of the job queue. |
| state | The state of the job queue. |
| status | The status of the job queue. |
| status_reason | The status_reason of the job queue. |
| priority | The priority of the job queue. |
| compute_environment_order (order) | The order of compute_environment_order of the job queue. |
| compute_environment_order (compute_environment) | The compute_environment of compute_environment_order of the job queue. |
| tags | The tags of the job queue. |

## Examples

### Ensure a job_queue name is available.
    describe aws_batch_job_queue(job_queue_name: 'test1') do
      its('job_definition_name') { should eq 'test1' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.
    describe aws_batch_job_queue(job_queue_name: 'test1') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_batch_job_queue(job_queue_name: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_batch_job_queue(job_queue_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the job_queue name is available.

    describe aws_batch_job_queue(job_queue_name: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `batch:client:describe_job_queues` action with `Effect` set to `Allow`.