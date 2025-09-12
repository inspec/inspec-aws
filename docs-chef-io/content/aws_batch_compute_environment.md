+++
title = "aws_batch_compute_environment resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_batch_compute_environment"
identifier = "inspec/resources/aws/aws_batch_compute_environment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_batch_compute_environment` InSpec audit resource to test the properties of a single AWS Batch compute environment.

For additional information, including details on parameters and properties, see the [AWS documentation on Batch compute environment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-computeenvironment.html).

## Syntax

Ensure that a compute_environment name exists.

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
  it { should exist }
end
```

## Parameters

`compute_environment_name` _(required)_

: The name of the Batch compute environment.

## Properties

`compute_environment_name`
: The name of the compute environment.

`compute_environment_arn`
: The ARN of the compute environment.

`ecs_cluster_arn`
: The ECS cluster ARN of the compute environment.

`tags`
: The tags of the compute environment.

`type`
: The type of the compute environment.

`state`
: The state of the compute environment.

`status`
: The status of the compute environment.

`status_reason`
: The status reason of the compute environment.

`compute_resources (type)`
: The type of compute resource for the compute environment.

`compute_resources (allocation_strategy)`
: The allocation strategy for the compute resources of the compute environment.

`compute_resources (minv_cpus)`
: The minimum number of vCPUs of the compute environment.

`compute_resources (maxv_cpus)`
: The maximum number of vCPUs of the compute environment.

`compute_resources (desiredv_cpus)`
: The desired number of vCPUs of the compute environment.

`compute_resources (instance_types)`
: The instance types of the compute environment.

`compute_resources (image_id)`
: The Amazon Machine Image (AMI) ID for instances launched in the compute environment.

`compute_resources (subnets)`
: The VPC subnets where the compute resources are launched.

`compute_resources (security_group_ids)`
: The EC2 security group IDs of the compute resources of the compute environment.

`compute_resources (ec2_key_pair)`
: The EC2 key pair for instances launched in the compute environment.

`compute_resources (instance_role)`
: The ECS instance profile of EC2 instances in the compute environment.

`compute_resources (tags)`
: The tags applied to EC2 instances in the compute environment.

`compute_resources (placement_group)`
: The EC2 placement group of the compute resources in the compute environment.

`compute_resources (bid_percentage)`
: The bid percentage of an instance in the compute environment.

`compute_resources (spot_iam_fleet_role)`
: The ARN of the EC2 Spot Fleet IAM role applied to a SPOT compute environment.

`compute_resources (launch_template (launch_template_id))`
: The ID of the launch template of the compute resources of the compute environment.

`compute_resources (launch_template (launch_template_name))`
: The name of the launch template of the compute resources of the compute environment.

`compute_resources (launch_template (version))`
: The version of the launch template of the compute resources of the compute environment.

`service_role`
: The service role of the compute environment.

## Examples

**Ensure a compute environment name is available.**

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
  its('compute_environment_name') { should eq 'COMPUTE_ENVIRONMENT_NAME' }
end
```

**Ensure that the state is `ENABLED` or `DISABLED`.**

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
    its('state') { should eq 'ENABLED' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the compute environment name is available.

```ruby
describe aws_batch_compute_environment(compute_environment_name: 'COMPUTE_ENVIRONMENT_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Batch:Client:DescribeComputeEnvironmentsResponse" %}}
