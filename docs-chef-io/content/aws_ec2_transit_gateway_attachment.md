+++
title = "aws_ec2_transit_gateway_attachment resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_transit_gateway_attachment"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_attachment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_attachment` InSpec audit resource to test properties of a single specific Transit Gateway attachment.

A Transit Gateway attachment attaches a VPC to a Transit Gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on Transit Gateway attachments](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html).

## Syntax

### Ensure that a Transit Gateway attachment ID exists

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id:'tgw-attach-006f2fd0a03d51323') do
  it { should exist }
end
```

### Ensure that a Transit Gateway attachment ID exists

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'dummy') do
  it { should exist }
end
```

## Parameters

`transit_gateway_attachment_id` _(required)_

## Properties

`transit_gateway_attachment_id`
: The IDs of the attachments.

`transit_gateway_id`
: The ID of the Transit Gateway.

`transit_gateway_owner_id`
: The ID of the AWS account that owns the Transit Gateway.

`resource_owner_id`
: The ID of the AWS account that owns the resource.

`resource_type`
: The resource type. Valid values are: `vpc`, `vpn`, `direct-connect-gateway`, `peering`, and `connect`.

`resource_id`
: The ID of the resource.

`state`
: The state of the attachment. Valid values are: `available`, `deleted`, `deleting`, `failed`, `failing`, `initiatingRequest`, `modifying`, `pendingAcceptance`, `pending`, `rollingBack`, `rejected`, and `rejecting`.

`association (transit_gateway_route_table_id)`
: The ID of the route table for the Transit Gateway.

`association (state)`
: The state of the attachment. Valid values are `associating`, `associated`, `disassociating`, and `disassociated`.

`creation_time`
: The creation time of the Transit Gateway.

`tags`
: The tags of the attachments.

## Examples

**Ensure a Transit Gateway attachment ID is available.**

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
  its('public_ip') { should eq 'tgw-attach-006f2fd0a03d51323' }
end
```

**Ensure that the state is `available` or `deleted`.**

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
  it { should_not exist }
end
```

### be_available

Check if the IP address is available.

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
  it { should be_available }
end
```

Use `should_not` to test an IP address that should not exist.

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
  it { should_not be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ec2:DescribeAddresses" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
