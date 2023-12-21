+++
title = "aws_ec2_transit_gateway_attachments Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_transit_gateway_attachments"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_attachments Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_attachments` InSpec audit resource to test properties of some or all AWS Transit Gateway attachments.

This resource does not expect any parameters.

For additional information, including details on parameters and properties, see the [AWS documentation on Transit Gateway attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Verify that a Transit Gateway attachment ID exists.

```ruby
describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id:'tgw-attach-006f2fd0a03d51323') do
  it { should exist }
end
```

An `aws_ec2_transit_gateway_attachments` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not require any parameters.

## Properties

`transit_gateway_attachment_ids`
: The IDs of the attachments.

`transit_gateway_ids`
: The ID of the Transit Gateway.

`transit_gateway_owner_ids`
: The ID of the AWS account that owns the Transit Gateway.

`resource_owner_ids`
: The ID of the AWS account that owns the resource.

`resource_types`
: The resource type. Valid values are: `vpc`, `vpn`, `direct-connect-gateway`, `peering`, and `connect`.

`resource_ids`
: The ID of the resource.

`states`
: The state of the attachment. Valid values are: `available`, `deleted`, `deleting`, `failed`, `failing`, `initiatingRequest`, `modifying`, `pendingAcceptance`, `pending`, `rollingBack`, `rejected`, and `rejecting`.

`associations (transit_gateway_route_table_id)`
: The ID of the route table for the Transit Gateway.

`associations (state)`
: The state of the attachment. Valid values are `associating`, `associated`, `disassociating`, and `disassociated`.

`creation_times`
: The creation time of the Transit Gateway.

`tags`
: The tags of the attachments.

## Examples

**Ensure a Transit Gateway attachment has transit_gateway_attachment_ids.**

```ruby
describe aws_ec2_transit_gateway_attachments do
  it { should exist }
end
```

**Match count of Transit Gateway attachment.**

```ruby
describe aws_ec2_transit_gateway_attachments do
    its('count') { should eq 5 }
end
```

**Check State whether it is correct or not.**

```ruby
describe aws_ec2_transit_gateway_attachments do
   its('states') { should include "available" }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity exist.

```ruby
describe aws_ec2_transit_gateway_attachments do
  it { should exist }
end
```


Use `should_not` to test the entity should not exist.

```ruby
describe aws_ec2_transit_gateway_attachments do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ec2:DescribeVpcEndpoints" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
