+++
title = "aws_ec2_network_interface_attachments resource"

draft = false


[menu.aws]
title = "aws_ec2_network_interface_attachments"
identifier = "inspec/resources/aws/aws_ec2_network_interface_attachments resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_interface_attachments` InSpec audit resource to test properties of multiple AWS EC2 network interface attachments.

The `AWS::EC2::NetworkInterfaceAttachment` resource attaches an elastic network interface (ENI) to an Amazon EC2 instance. You can use this resource type to attach additional network interfaces to an instance without interruption.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html).

## Syntax

Ensure that a network interface attachment exists.

```ruby
describe aws_ec2_network_interface_attachments do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`attach_times`
: The timestamp indicating when the attachment initiated.

: **Field**: `attach_time`

`attachment_ids`
: The ID of the network interface attachment.

: **Field**: `attachment_id`

`delete_on_terminations`
: Indicates whether the network interface is deleted when the instance is terminated.

: **Field**: `delete_on_termination`

`device_indexes`
: The device index of the network interface attachment on the instance.

: **Field**: `device_index`

`network_card_indexes`
: The index of the network card.

: **Field**: `network_card_index`

`instance_ids`
: The ID of the instance.

: **Field**: `instance_id`

`instance_owner_ids`
: The Amazon Web Services account ID of the owner of the instance.

: **Field**: `instance_owner_id`

`statuses`
: The attachment state.

: **Field**: `status`

## Examples

Ensure an attachment ID is available:

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  its('attachment_ids') { should include 'ATTACHMENT_ID' }
end
```

Ensure that a network interface status is `available`:

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
    its('statuses') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_interface_attachments do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_interface_attachments do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInterfacesResult" %}}
