---
title: About the aws_batch_job_queue Resource
platform: aws
---

# aws\_batch\_job\_queue

Use the `aws_batch_job_queue` InSpec audit resource to test the properties of a single AWS Batch job queue.

## Syntax

Ensure that a job_queue name exists.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      it { should exist }
    end

## Parameters

`job_queue_name` _(required)_

The name of the job queue.

For additional information, see the [AWS Batch job queues documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobqueue.html).

## Properties

| Property | Description|
| --- | --- |
| job_queue_name | The name of the job queue. |
| job_queue_arn | The ARN of the job queue. |
| state | The state of the job queue. |
| status | The status of the job queue. |
| status_reason | The status_reason of the job queue. |
| priority | The priority of the job queue. |
| compute_environment_order (order) | The order of the compute environment of the job queue. |
| compute_environment_order (compute_environment) | The ARN of the compute environment of the job queue. |
| tags | The tags of the job queue. |

## Examples

### Ensure a job queue name is available.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      its('job_queue_name') { should eq 'JOB_QUEUE_NAME' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the job_queue name is available.

    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Batch:Client:DescribeJobQueuesResponse` action with `Effect` set to `Allow`.