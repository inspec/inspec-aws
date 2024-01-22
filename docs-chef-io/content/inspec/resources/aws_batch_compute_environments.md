+++
title = "aws_batch_compute_environments Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_batch_compute_environments"
identifier = "inspec/resources/aws/aws_batch_compute_environments Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_batch_compute_environments` InSpec audit resource to test properties of multiple AWS Batch compute environments.

For additional information, including details on parameters and properties, see the [AWS documentation on Batch compute environment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-computeenvironment.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a compute environment exists.

```ruby
describe aws_batch_compute_environments do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`compute_environment_names`
: The name of the compute environment.

`compute_environment_arns`
: The ARN of the compute environment.

`ecs_cluster_arns`
: The ECS cluster ARN of the compute environment.

`tags`
: The tags of the compute environment.

`types`
: The type of the compute environment.

`states`
: The state of the compute environment.

`statuses`
: The status of the compute environment.

`status_reasons`
: The status reason of the compute environment.

`service_roles`
: The service role of the compute environment.

## Examples

**Ensure a work group name is available.**

```ruby
describe aws_batch_compute_environments do
  its('compute_environment_names') { should include 'COMPUTE_ENVIRONMENT_NAME' }
end
```

**Ensure that the state is `ENABLED` or `DISABLED`.**

```ruby
describe aws_batch_compute_environments do
    its('states') { should include 'ENABLED' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_batch_compute_environments do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_batch_compute_environments do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the compute environments are available.

```ruby
describe aws_batch_compute_environments do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Batch:Client:DescribeComputeEnvironmentsResponse" %}}
