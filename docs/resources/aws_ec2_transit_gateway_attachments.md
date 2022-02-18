---
title: About the aws_ec2_transit_gateway_attachments Resource
platform: aws
---

# aws_ec2_transit_gateway_attachments

Use the `aws_ec2_transit_gateway_attachments` InSpec audit resource to test properties of some or all AWS Transit Gateway Attachments.

## Syntax

Verify that a Transit Gateway attachment ID exists.

    describe aws_ec2_transit_gateway_attachment(transit_gateway_attachment_id:'tgw-attach-006f2fd0a03d51323') do
      it { should exist }
    end

An `aws_ec2_transit_gateway_attachments` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on the `AWS::Batch::JobDefinition` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).


See the [AWS documentation on Transit Gateway Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html) for additional information.

## Properties

| Property  | Description | Field |
| --- | --- | --- |
| transit_gateway_attachment_ids | The IDs of the attachments. | transit_gateway_attachment_id |
| transit_gateway_ids | The ID of the Transit Gateway. | transit_gateway_id |
| transit_gateway_owner_ids | The ID of the AWS account that owns the Transit Gateway. | transit_gateway_owner_id |
| resource_owner_ids | The ID of the AWS account that owns the resource. | resource_owner_id |
| resource_types | The resource type. Valid values are: `vpc`, `vpn`, `direct-connect-gateway`, `peering`, and `connect`. | resource_type |
| resource_ids | The ID of the resource. | resource_id |
| states | The state of the attachment. Valid values are: `available`, `deleted`, `deleting`, `failed`, `failing`, `initiatingRequest`, `modifying`, `pendingAcceptance`, `pending`, `rollingBack`, `rejected`, and `rejecting`. | state |
| associations | The association of the Transit Gateway. | association |
| creation_times | The creation time of the Transit Gateway. | creation_time |
| tags | The tags of the attachments. | tags |

## Examples

##### Ensure a Transit Gateway has an attachment.

    describe aws_ec2_transit_gateway_attachments do
      it { should exist }
    end

##### Match count of Transit Gateway attachment.

    describe aws_ec2_transit_gateway_attachments do
        its('count') { should eq 5 }
    end

##### Check State whether it is correct or not.

    describe aws_ec2_transit_gateway_attachments do
       its('states') { should include "available" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity exist.

    describe aws_ec2_transit_gateway_attachments do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_ec2_transit_gateway_attachments do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeTransitGatewayAttachmentsResult` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
