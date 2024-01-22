+++
title = "aws_batch_job_definition Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_batch_job_definition"
identifier = "inspec/resources/aws/aws_batch_job_definition Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_batch_job_definition` InSpec audit resource to test the properties of a single specific Batch job definition.

The AWS::Batch::JobDefinition resource specifies the parameters for an AWS Batch job definition.

For additional information, including details on parameters and properties, see the [AWS documentation on Batch Job Definition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a job definition name exists.

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
  it { should exist }
end
```

## Parameters

`job_definition_name` _(required)_

: The name of the job definition.

## Properties

`job_definition_name`
: The name of the job definition.

`job_definition_arn`
: The ARN of the job definition.

`revision`
: The revision of the job definition.

`status`
: The status of the job definition.

`type`
: The type of the job definition.

`parameters`
: The parameters of the job definition.

`container_properties (image)`
: The container image in the job definition.

`container_properties (vcpus)`
: The number of vCPUs reserved for the container in the job definition.

`container_properties (memory)`
: The hard limit of the container's memory in the job definition.

`container_properties (command)`
: The command passed to the container in the job definition.

`container_properties (job_role_arn)`
: The ARN of the IAM role that the container can assume for AWS permissions in the job definition.

`container_properties (execution_role_arn)`
: The execution role ARN that the AWS Batch can assume in the job definition.

`container_properties (volumes)`
: The list of the data volumes in the job definition.

`container_properties (environment)`
: The environment variables to pass to a container in the job definition.

`container_properties (mount_points)`
: The mount points for the data volumes in the container in the job definition.

`container_properties (readonly_root_filesystem)`
: Whether the container is given read-only access to its root file system in the job definition.

`container_properties (privileged)`
: Whether the container is given elevated permissions on the host container instance.

`container_properties (ulimits)`
: The list of ulimits to set in the container in the job definition.

`container_properties (user)`
: The user name to use in the container in the job definition.

`container_properties (instance_type)`
: The instance type to use for a multi-node parallel job.

`container_properties (resource_requirements)`
: The type and amount of resources to assign to a container in the job definition.

`container_properties (linux_parameters (shared_memory_size))`
: The value in MiB of the `/dev/shm` volume for the container in the job definition.

`container_properties (linux_parameters (tmpfs))`
: The container path, mount options, and size (in MiB) of the tmpfs mount for the container in the job definition.

`container_properties (linux_parameters (max_swap))`
: The total amount of swap memory (in MiB) a container can use.

`container_properties (linux_parameters (swappiness))`
: The container's memory swappiness behavior in the job definition.

`container_properties (linux_parameters (shared_memory_size))`
: The shared_memory_size of the log configuration of the container properties of the job definition.

`container_properties (log_configuration (options))`
: The log configuration options to send to the log driver for the container in the job.

`container_properties (secrets)`
: The secrets for the job that are exposed as environment variables.

`timeout (attempt_duration_seconds)`
: The timeout duration in seconds of the job definition.

`node_properties (num_nodes)`
: The number of nodes that are associated with a multi-node parallel job in the job definition.

`node_properties (main_node)`
: The node index for the main node of a multi-node parallel job.

`node_properties (node_range_properties)`
: A list of node ranges and their properties that are associated with a multi-node parallel job.

`tags`
: The tags of the job definition.

`propagate_tags`
: Whether to propagate tags from the job definition to the ECS task.

`platform_capabilities`
: The platform capabilities required by the job definition.

## Examples

**Ensure a job definition name is available.**

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
  its('job_definition_name') { should eq 'JOB_DEFINITION_NAME' }
end
```

**Ensure that the status is `ACTIVE`.**

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
    its('status') { should eq 'ACTIVE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the job definition name is available.

```ruby
describe aws_batch_job_definition(job_definition_name: 'JOB_DEFINITION_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Batch:Client:DescribeJobDefinitionsResponse" %}}
