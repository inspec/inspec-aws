+++
title = "aws_ec2_host resource"

draft = false


[menu.aws]
title = "aws_ec2_host"
identifier = "inspec/resources/aws/aws_ec2_host resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_host` InSpec audit resource to test properties of a single AWS EC2 host resource.

The `AWS::EC2::host` allocates a fully dedicated physical server for launching EC2 instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 host.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html).

## Syntax

Ensure that the host exists.

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
  it { should exist }
end
```

## Parameters

`host_id` _(required)_

: The ID of the dedicated host.

## Properties

`auto_placement`
: Whether auto-placement is on or off.

`availability_zone`
: The Availability Zone of the Dedicated host.

`available_capacity.available_instance_capacity`
: The number of instances that can be launched onto the Dedicated host based on the host's available capacity.

`available_capacity.available_v_cpus`
: The number of vCPUs available for launching instances onto the Dedicated host.

`client_token`
: Unique, case-sensitive identifier that you provide to ensure the idempotency of the request.

`host_id`
: The ID of the Dedicated host.

`host_properties.cores`
: The number of cores on the Dedicated host.

`host_properties.instance_type`
: The instance type supported by the Dedicated host.

`host_properties.instance_family`
: The instance family supported by the Dedicated host.

`host_properties.sockets`
: The number of sockets on the Dedicated host.

`host_properties.total_v_cpus`
: The total number of vCPUs on the Dedicated host.

`host_reservation_id`
: The reservation ID of the Dedicated host.

`instances`
: The IDs and instance type that are currently running on the Dedicated host.

`state`
: The Dedicated host's state.

`allocation_time`
: The time that the Dedicated host was allocated.

`release_time`
: The time that the Dedicated host was released.

`tags`
: Any tags assigned to the Dedicated host.

`host_recovery`
: Indicates whether host recovery is enabled or disabled for the Dedicated host.

`allows_multiple_instance_types`
: Indicates whether the Dedicated host supports multiple instance types of the same instance family.

`owner_id`
: The ID of the Amazon Web Services account that owns the Dedicated host.

`availability_zone_id`
: The ID of the Availability Zone in which the Dedicated host is allocated.

`member_of_service_linked_resource_group`
: Indicates whether the Dedicated host is in a host resource group.

## Examples

Ensure a host is available:

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
  its('host_id') { should eq 'DEDICATED_HOST_ID' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeHostsResult" %}}
