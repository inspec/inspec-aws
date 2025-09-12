+++
title = "aws_ami resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ami"
identifier = "inspec/resources/aws/aws_ami resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ami` InSpec audit resource to test properties of a single AWS AMI.

For additional information, including details on parameters and properties, see the [AWS documentation on EC2 Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html).

## Syntax

An `aws_ami` resource block declares the tests for a single AWS AMI by image id.

```ruby
describe aws_ami(image_id: 'aki-2349e94458a507') do
  it { should exist }
end
```

## Parameters

`image_id` _(required)_

: This resource accepts a single parameter, the AMI Image ID.
  This can be passed either as a string or as a `image_id: 'value'` key-value entry in a hash.

## Properties

`architecture`
: The architecture of the image.

`creation_date`
: The date and time the image was created.

`image_id`
: The ID of the AMI.

`image_location`
: The location of the AMI.

`image_type`
: The type of image.

`public`
: Indicates whether the image has public launch permissions.

`kernel_id`
: The kernel associated with the image, if any. Only applicable for machine images.

`owner_id`
: The AWS account ID of the image owner.

`platform`
: This value is set to windows for Windows AMIs; otherwise, it is blank.

`platform_details`
: The platform details associated with the billing code of the AMI.

`usage_operation`
: The operation of the Amazon EC2 instance and the billing code that is associated with the AMI.

`product_codes`
: Any product codes associated with the AMI.

`ramdisk_id`
: The RAM disk associated with the image, if any. Only applicable for machine images.

`state`
: The state of the AMI.

`block_device_mappings`
: Any block device mapping entries.

`description`
: The description of the AMI that was provided during image creation.

`ena_support`
: Specifies whether enhanced networking with ENA is enabled.

`hypervisor`
: The hypervisor type of the image.

`image_owner_alias`
: The AWS account alias or the AWS account ID of the AMI owner.

`name`
: The name of the AMI that was provided during image creation.

`root_device_name`
: The device name of the root device volume.

`root_device_type`
: The type of root device used by the AMI.

`sriov_net_support`
: Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled.

`state_reason`
: Provides the reason for the state change.

`tags`
: Provides any tags assigned to the image.

`virtualization_type`
: The type of virtualization of the AMI.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Image.html)

## Examples

**Check if an AMI is public.**

```ruby
describe aws_ami(image_id: 'aki-25348fd4323') do
  it { should be_public }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_public

The `be_public` matcher tests if the AMI has public launch permissons.

```ruby
describe aws_ami(image_id: 'aki-1234') do
  it { should be_public }
end
```

```ruby
describe aws_ami(image_id: 'aki-6789') do
  it { should_not be_public }
end
```

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ami(image_id: 'aki-1234') do
  it { should exist }
end
```

```ruby
describe aws_ami(image_id: 'aki-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeImages" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
