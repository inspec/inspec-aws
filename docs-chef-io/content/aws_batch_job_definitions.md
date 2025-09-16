+++
title = "aws_batch_job_definitions resource"

draft = false


[menu.aws]
title = "aws_batch_job_definitions"
identifier = "inspec/resources/aws/aws_batch_job_definitions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_batch_job_definitions` InSpec audit resource to test properties of multiple AWS Batch job definitions.

The AWS::Batch::JobDefinition resource specifies the parameters for an AWS Batch job definition.

For additional information, including details on parameters and properties, see the [AWS documentation on Batch Job Definition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Syntax

Ensure that a job definition exists.

```ruby
describe aws_batch_job_definitions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`job_definition_names`
: The name of the job definition.

`job_definition_arns`
: The ARN of the job definition.

`revisions`
: The revision of the job definition.

`statuses`
: The status of the job definition.

`types`
: The type of the job definition.

`parameters`
: The parameter of the job definition.

`tags`
: The tags of the job definition.

`propagate_tags`
: Whether to propagate tags from the job definition to the ECS task.

`platform_capabilities`
: The platform capabilities required by the job definition.

## Examples

Ensure a job definition name is available:

```ruby
describe aws_batch_job_definitions do
  its('job_definition_names') { should include 'JOB_DEFINITION_NAME' }
end
```

Ensure that the status is `ACTIVE`:

```ruby
describe aws_batch_job_definitions do
    its('statuses') { should include 'ACTIVE' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_batch_job_definitions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_batch_job_definitions do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the job_definition name is available.

```ruby
describe aws_batch_job_definitions do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Batch:Client:DescribeJobDefinitionsResponse" %}}
