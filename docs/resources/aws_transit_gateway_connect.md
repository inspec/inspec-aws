---
title: About the aws_transit_gateway_connect Resource
platform: aws
---

# aws\_transit\_gateway\_connect

Use the `aws_transit_gateway_connect` InSpec audit resource to test properties of a single specific AWS EC2 TransitGatewayConnect.

The AWS::EC2::TransitGatewayConnect resource creates a Connect attachment from a specified transit gateway attachment.

## Syntax

Ensure that transit gateway connect exists.

    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-1234567890') do
      it { should exits }
    end

## Parameters

`transit_gateway_attachment_ids` _(required)_

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayConnect](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayconnect.html).

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_attachment_id | The ID of the Connect attachment. |
| transport_transit_gateway_attachment_id | The ID of the attachment from which the Connect attachment was created. |
| transit_gateway_id | The ID of the transit gateway. |
| state | The state of the attachment. |
| creation_time | The creation time. |
| options (protocol) | The Connect attachment options. The tunnel protocol. |
| tags | The tags for the attachment. |

## Examples

### Ensure a transit gateway attachment id is available.
    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-1234567890') do
      its('transit_gateway_attachment_id') { should eq 'tgw-attach-1234567890' }
    end

### Ensure that the state is `available`.
    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-1234567890') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'tgw-attach-1234567890') do
      it { should exits }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'dummy') do
      it { should_not exits }
    end

### be_available

Use `should` to check if the function is available.

    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'dummy') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_transit_gateway_connects` action with `Effect` set to `Allow`.