---
title: About the aws_batch_job_definitions Resource
platform: aws
---

# aws_batch_job_definitions

Use the `aws_batch_job_definitions` InSpec audit resource to test properties of multiple AWS Batch job definitions.

The AWS::Batch::JobDefinition resource specifies the parameters for an AWS Batch job definition.

## Syntax

Ensure that a job definition exists.

    describe aws_batch_job_definitions do
      it { should exist }
    end

## Parameters

This resource does not accept any parameters.

For additional information, see the [AWS documentation on Batch Job Definition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description | Fields |
| ---  | --- | --- |
| job_definition_names | The name of the job definition. | job_definition_name |
| job_definition_arns | The ARN of the job definition. | job_definition_arn |
| revisions | The revision of the job definition. | revision |
| statuses | The status of the job definition. | status |
| types | The type of the job definition. | type |
| parameters | The parameter of the job definition. | parameters |
| tags | The tags of the job definition. | tags |
| propagate_tags | Whether to propagate tags from the job definition to the ECS task. | propagate_tags |
| platform_capabilities | The platform capabilities required by the job definition. | platform_capabilities |

## Examples

### Ensure a job definition name is available.

    describe aws_batch_job_definitions do
      its('job_definition_names') { should include 'JOB_DEFINITION_NAME' }
    end

### Ensure that the status is `ACTIVE`.

    describe aws_batch_job_definitions do
        its('statuses') { should include 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_batch_job_definitions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_batch_job_definitions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_batch_job_definitions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Batch:Client:DescribeJobDefinitionsResponse` action with `Effect` set to `Allow`.
