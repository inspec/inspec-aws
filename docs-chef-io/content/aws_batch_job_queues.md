+++
title = "aws_batch_job_queues resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_batch_job_queues"
identifier = "inspec/resources/aws/aws_batch_job_queues resource"
parent = "inspec/resources/aws"
+++

Use the `aws_batch_job_queues` InSpec audit resource to test the properties of multiple AWS Batch job queues.

For additional information, including details on parameters and properties, see the [AWS Batch job queues documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobqueue.html).

## Syntax

Ensure that a job queue exists.

```ruby
describe aws_batch_job_queues do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`job_queue_names`
: The name of the job queue.

`job_queue_arns`
: The ARN of the job queue.

`states`
: The state of the job queue.

`statuses`
: The status of the job queue.

`status_reasons`
: The status_reason of the job queue.

`priorities`
: The priority of the job queue.

`tags`
: The tags of the job queue.

## Examples

**Ensure a job queue name is available.**

```ruby
describe aws_batch_job_queues do
  its('job_queue_names') { should include 'JOB_QUEUE_NAME' }
end
```

**Ensure that the state is `ENABLED` or `DISABLED`.**

```ruby
describe aws_batch_job_queues do
    its('states') { should include 'ENABLED' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_batch_job_queues do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_batch_job_queues do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the job_queue name is available.

```ruby
describe aws_batch_job_queues do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Batch:Client:DescribeJobQueuesResponse" %}}
