+++
title = "aws_transit_gateway_connects resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_transit_gateway_connects"
identifier = "inspec/resources/aws/aws_transit_gateway_connects resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_connects` InSpec audit resource to test properties of multiple AWS EC2 Transit Gateway Connect.

The `AWS::EC2::TransitGatewayConnect` resource creates a Connect attachment from a specified transit gateway attachment.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayConnect](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayconnect.html).

## Syntax

Ensure that Transit Gateway Connect exists.

```ruby
describe aws_transit_gateway_connects do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`transit_gateway_attachment_ids`
: The ID of the Connect attachment.

`transport_transit_gateway_attachment_ids`
: The ID of the attachment from which the Connect attachment was created.

`transit_gateway_ids`
: The ID of the transit gateway.

`states`
: The state of the attachment.

`creation_times`
: The creation time.

`options`
: The Connect attachment options. The tunnel protocol.

`tags`
: The tags for the attachment.

## Examples

Ensure a transit gateway attachment ID is available:

```ruby
describe aws_transit_gateway_connects do
  its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ATTACHMENT_ID' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_transit_gateway_connects do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_connects do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_connects do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_connects do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTransitGatewayConnectsResult" %}}
