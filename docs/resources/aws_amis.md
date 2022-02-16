---
title: About the aws_amis Resource
platform: aws
---

# aws_amis

Use the `aws_amis` InSpec audit resource to test properties of some or all AWS AMIs.

## Syntax

 Ensure you have exactly 3 AMIs available to you.

    describe aws_amis(all_amis: 'true') do
      its('image_ids.count') { should cmp 3 }
    end

 Check if you have a public AMI for the Linux/UNIX platform available to you.

    describe aws_amis(is_public: 'true', platform_details: 'Linux/UNIX') do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

This resource must be provided with the parameter 'all_amis' (returns ALL AMIs available to you) OR a combination of the following.

`all_amis` _(optional)_

_OR_

`architecture` _(optional)_
`creation_date` _(optional)_
`image_id` _(optional)_
`image_type` _(optional)_
`is_public` _(optional)_
`kernel_id` _(optional)_
`owner_id` _(optional)_
`owners` _(optional)_
    - Scopes the results to images with the specified owners. You can specify a combination of AWS account IDs, `self`, `amazon`, and `aws-marketplace`.
    If you omit this parameter, the results include all images for which you have launch permissions, regardless of ownership.
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

See also the [AWS documentation on EC2 Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| architectures | The architecture of the image. | architecture |
| creation_dates | The date and time the image was created. | creation_date |
| image_ids | The ID of the AMI. | image_id |
| image_locations | The location of the AMI. | image_location |
| image_types | The type of image. | image_type |
| public | Indicates whether the image has public launch permissions. | public |
| kernel_ids | The kernel associated with the image, if any. Only applicable for machine images. | kernel_id |
| owner_ids | The AWS account ID of the image owner. | owner_id |
| platforms | This value is set to windows for Windows AMIs; otherwise, it is blank. | platform |
| platform_details | The platform details associated with the billing code of the AMI. | platform_details |
| usage_operations | The operation of the Amazon EC2 instance and the billing code that is associated with the AMI. | usage_operation |
| product_codes | Any product codes associated with the AMI. | product_codes |
| ramdisk_ids | The RAM disk associated with the image, if any. Only applicable for machine images. | ramdisk_id |
| states | The state of the AMI. | state |
| block_device_mappings | Any block device mapping entries. | block_device_mappings |
| descriptions | The description of the AMI that was provided during image creation. | description |
| ena_support | Specifies whether enhanced networking with ENA is enabled. | ena_support |
| hypervisors | The hypervisor type of the image. | hypervisor |
| image_owner_alias | The AWS account alias or the AWS account ID of the AMI owner. | image_owner_alias |
| names | The name of the AMI that was provided during image creation. | name |
| root_device_names | The device name of the root device volume. | root_device_name |
| root_device_types | The type of root device used by the AMI. | root_device_type |
| sriov_net_supports | Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled. | sriov_net_support |
| state_reasons | Provides the reason for the state change. | state_reason |
| tags | Provides any tags assigned to the image. | tags |
| virtualization_types | The type of virtualization of the AMI. | virtualization_type |

## Examples

### Ensure ID of an AMI exists

    describe aws_amis(all_amis: 'true') do
      its('image_ids') { should include 'image-id-43542' }
    end

### Interrogate AMIs Belong to the Current User Only

    describe aws_amis(owners: 'self') do
      its('owner_ids.uniq.size') { should be 1 }
      its('owner_ids.uniq.first') { should eq 12345678 }
    end

### Interrogate AMIs Belong to the Current User and the Amazon

    describe aws_amis(owners: ['self', 'amazon']) do
      it { should exist }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_amis(all_amis: 'true').where( <property>: <value>) do
      it { should exist }
    end

    describe aws_amis(all_amis: 'true').where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeImages` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).