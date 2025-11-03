+++
title = "aws_ec2_hosts resource"

draft = false


[menu.aws]
title = "aws_ec2_hosts"
identifier = "inspec/resources/aws/aws_ec2_hosts resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_hosts` InSpec audit resource to test properties of multiple AWS EC2 host resources.

The `AWS::EC2::host` allocates a fully dedicated physical server for launching EC2 instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 host.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html).

## Syntax

Ensure that the host exists.

```ruby
describe aws_ec2_hosts do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`auto_placements`
: Whether auto-placement is on or off.

: **Field**: `auto_placement`

`availability_zones`
: The Availability Zone of the Dedicated host.

: **Field**: `availability_zone`

`available_capacities`
: The number of instances that can be launched onto the Dedicated host depending on the host's available capacity.

: **Field**: `available_instance_capacity`

`client_tokens`
: Unique, case-sensitive identifier that you provide to ensure the idempotency of the request.

: **Field**: `client_token`

`host_ids`
: The ID of the Dedicated host.

: **Field**: `host_id`

`host_properties`
: The hardware specifications of the Dedicated host.

: **Field**: `host_properties`

`host_reservation_ids`
: The reservation ID of the Dedicated host.

: **Field**: `host_reservation_id`

`instances`
: The IDs and instance type that are currently running on the Dedicated host.

: **Field**: `instances`

`states`
: The Dedicated host's state.

: **Field**: `state`

`allocation_times`
: The time that the Dedicated host was allocated.

: **Field**: `allocation_time`

`release_times`
: The time that the Dedicated host was released.

: **Field**: `release_time`

`tags`
: Any tags assigned to the Dedicated host.

: **Field**: `tags`

`host_recoveries`
: Indicates whether host recovery is enabled or disabled for the Dedicated host.

: **Field**: `host_recovery`

`allows_multiple_instance_types`
: Indicates whether the Dedicated host supports multiple instance types of the same instance family.

: **Field**: `allows_multiple_instance_types`

`owner_ids`
: The ID of the Amazon Web Services account that owns the Dedicated host.

: **Field**: `owner_id`

`availability_zone_ids`
: The ID of the Availability Zone in which the Dedicated host is allocated.

: **Field**: `availability_zone_id`

`member_of_service_linked_resource_groups`
: Indicates whether the Dedicated host is in a host resource group.

: **Field**: `member_of_service_linked_resource_group`

## Examples

Ensure a host is available:

```ruby
describe aws_ec2_hosts do
  its('host_ids') { should include 'DEDICATED_HOST_ID' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_hosts do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_hosts do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_hosts do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_hosts do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeHostsResult" %}}
