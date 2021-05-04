---
title: About the aws_ec2_transit_gateway_attachment Resource
platform: aws
---

# aws\_eip

Use the `aws_ec2_transit_gateway_attachment` InSpec audit resource to test properties of a single specific Transit Gateway Attachment. 

An Transit Gateway Attachment attaches a VPC to a transit gateway.

## Syntax

### Ensure that a Transit Gateway Attachment ID exists.

    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id:'tgw-attach-006f2fd0a03d51323') do
      it { should exist }
    end

### Ensure that a Transit Gateway Attachment ID exists.
    
    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'dummy') do
      it { should exist }
    end

## Parameters

`transit_gateway_attachment_id` _(required)_

For additional information, see the [AWS documentation on Transit Gateway Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html).

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_attachment_id | The IDs of the attachments. |
| transit_gateway_id | The ID of the transit gateway. |
| transit_gateway_owner_id | The ID of the AWS account that owns the transit gateway. |
| resource_owner_id | The ID of the AWS account that owns the resource. |
| resource_type | The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect. |
| resource_id | The ID of the resource. |
| state | The state of the attachment. Valid values are available, deleted, deleting, failed, failing, initiatingRequest, modifying, pendingAcceptance, pending, rollingBack, rejected, rejecting. |
| association (transit_gateway_route_table_id) | The ID of the route table for the transit gateway. |
| association (state) | The state of the attachment. Valid values are associating, associated, disassociating, disassociated | |
| creation_time | The creation time of the transit gateway. |
| tags | The tags of the attachments. |

## Examples

### Ensure a Transit Gateway Attachment ID is available.
    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
      its('public_ip') { should eq 'tgw-attach-006f2fd0a03d51323' }
    end

### Ensure that the state is `availble` or `deleted`.
    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
        its('state') { should eq 'availble' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
      it { should_not exist }
    end

### be_available

Check if the IP address is available.

    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
      it { should be_available }
    end

Use `should_not` to test an IP address that should not exist.

    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id: 'tgw-attach-006f2fd0a03d51323') do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeAddresses` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.