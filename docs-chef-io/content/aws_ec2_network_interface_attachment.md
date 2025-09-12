+++
title = "aws_ec2_network_interface_attachment resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_network_interface_attachment"
identifier = "inspec/resources/aws/aws_ec2_network_interface_attachment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_interface_attachment` InSpec audit resource to test properties of a single specific AWS EC2 network interface attachment.

The `AWS::EC2::NetworkInterfaceAttachment` resource attaches an elastic network interface (ENI) to an Amazon EC2 instance. You can use this resource type to attach additional network interfaces to an instance without interruption.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 network interface attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface-attachment.html).

## Syntax

Ensure that network interface attachment exists.

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  it { should exist }
end
```

## Parameters

`network_interface_id` _(required)_

: The ID of the network interface.

## Properties

`attach_time`
: The timestamp indicating when the attachment initiated.

`attachment_id`
: The ID of the network interface attachment.

`delete_on_termination`
: Indicates whether the network interface is deleted when the instance is terminated.

`device_index`
: The device index of the network interface attachment on the instance.

`network_card_index`
: The index of the network card.

`instance_id`
: The ID of the instance.

`instance_owner_id`
: The Amazon Web Services account ID of the owner of the instance.

`status`
: The attachment state.

## Examples

Ensure aN attachment ID is available:

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  its('attachment_id') { should eq 'ATTACHMENT_ID' }
end
```

Ensure that the status is `available`:

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
    its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInterfacesResult" %}}
