+++
title = "aws_amis resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_amis"
identifier = "inspec/resources/aws/aws_amis resource"
parent = "inspec/resources/aws"
+++

Use the `aws_amis` InSpec audit resource to test properties of some or all AWS AMIs.

## Syntax

 Ensure you have exactly 3 AMIs available to you.

```ruby
describe aws_amis(all_amis: 'true') do
  its('image_ids.count') { should cmp 3 }
end
```

 Check if you have a public AMI for the Linux/UNIX platform available to you.

```ruby
describe aws_amis(is_public: 'true', platform_details: 'Linux/UNIX') do
  it { should exist }
end
```

## Parameters

This resource must be provided with the parameter 'all_amis' (returns ALL AMIs available to you) OR a combination of the following.

`all_amis` _(optional)_

: _OR_

`architecture` _(optional)_

`creation_date` _(optional)_
`image_id` _(optional)_
`image_type` _(optional)_
`is_public` _(optional)_
`kernel_id` _(optional)_
`owner_id` _(optional)_
`owners` _(optional)_

:     - Scopes the results to images with the specified owners. You can specify a combination of AWS account IDs, `self`, `amazon`, and `aws-marketplace`.

  ```ruby
  If you omit this parameter, the results include all images for which you have launch permissions, regardless of ownership.
  ```

`owner_alias` _(optional)_
`platform` _(optional)_

`product_code` _(optional)_
`platform_details` _(optional)_
`usage_operation` _(optional)_
`ramdisk_id` _(optional)_
`state` _(optional)_

`state_reason_code` _(optional)_
`state_reason_message` _(optional)_
`description` _(optional)_

`ena_support` _(optional)_
`hypervisor` _(optional)_

`name` _(optional)_

`root_device_name` _(optional)_
`root_device_type` _(optional)_
`sriov_net_support` _(optional)_
`virtualization_type` _(optional)_

: This can be passed either as a string or as a `all_amis: 'value'` key-value entry in a hash.

## Properties

`architectures`
: The architecture of the image.

`creation_dates`
: The date and time the image was created.

`image_ids`
: The ID of the AMI.

`image_locations`
: The location of the AMI.

`image_types`
: The type of image.

`public`
: Indicates whether the image has public launch permissions.

`kernel_ids`
: The kernel associated with the image, if any. Only applicable for machine images.

`owner_ids`
: The AWS account ID of the image owner.

`platforms`
: This value is set to windows for Windows AMIs; otherwise, it is blank.

`platform_details`
: The platform details associated with the billing code of the AMI.

`usage_operations`
: The operation of the Amazon EC2 instance and the billing code that is associated with the AMI.

`product_codes`
: Any product codes associated with the AMI.

`ramdisk_ids`
: The RAM disk associated with the image, if any. Only applicable for machine images.

`states`
: The state of the AMI.

`block_device_mappings`
: Any block device mapping entries.

`descriptions`
: The description of the AMI that was provided during image creation.

`ena_support`
: Specifies whether enhanced networking with ENA is enabled.

`hypervisors`
: The hypervisor type of the image.

`image_owner_alias`
: The AWS account alias or the AWS account ID of the AMI owner.

`names`
: The name of the AMI that was provided during image creation.

`root_device_names`
: The device name of the root device volume.

`root_device_types`
: The type of root device used by the AMI.

`sriov_net_supports`
: Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled.

`state_reasons`
: Provides the reason for the state change.

`tags`
: Provides any tags assigned to the image.

`virtualization_types`
: The type of virtualization of the AMI.

## Examples

**Ensure ID of an AMI exists.**

```ruby
describe aws_amis(all_amis: 'true') do
  its('image_ids') { should include 'image-id-43542' }
end
```

**Interrogate AMIs Belong to the Current User Only.**

```ruby
describe aws_amis(owners: 'self') do
  its('owner_ids.uniq.size') { should be 1 }
  its('owner_ids.uniq.first') { should eq 12345678 }
end
```

**Interrogate AMIs Belong to the Current User and the Amazon.**

```ruby
describe aws_amis(owners: ['self', 'amazon']) do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_amis(all_amis: 'true').where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe aws_amis(all_amis: 'true').where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeImages" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
