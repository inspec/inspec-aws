---
title: About the aws_ec2_images Resource
platform: aws
---

# aws\_ec2\_images

Use the `aws_ec2_images` InSpec audit resource to test properties of some or all AWS EC2 images.

## Syntax

 Ensure you have exactly 3 EC2 Images

    describe aws_ec2_images do
      its('image_ids.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

## Properties

|Property                 | Description|
| ---                     | --- |
|architectures            | The architecture of the image. |
|creation\_dates          | The date and time the image was created. |
|image\_ids               | The ID of the AMI. |
|image\_locations         | The location of the AMI. |
|image\_types             | The type of image. |
|public                   | Indicates whether the image has public launch permissions. |
|kernal\_ids              | The kernel associated with the image, if any. Only applicable for machine images. |
|owner\_ids               | The AWS account ID of the image owner. |
|platforms                | This value is set to windows for Windows AMIs; otherwise, it is blank. |
|platform\_details        | The platform details associated with the billing code of the AMI. |
|usage\_operations        | The operation of the Amazon EC2 instance and the billing code that is associated with the AMI. |
|product\_codes           | Any product codes associated with the AMI. |
|ramdisk\_ids             | The RAM disk associated with the image, if any. Only applicable for machine images. |
|states                   | The state of the AMI. |
|block\_device\_mappings  | Any block device mapping entries. |
|descriptions             | The description of the AMI that was provided during image creation. |
|ena\_support             | Specifies whether enhanced networking with ENA is enabled. |
|hypervisor               | The hypervisor type of the image. |
|image\_owner\_alias      | The AWS account alias or the AWS account ID of the AMI owner. |
|names                    | The name of the AMI that was provided during image creation. |
|root\_device\_names      | The device name of the root device volume. |
|root\_device\_types      | The type of root device used by the AMI. |
|sriov\_net\_supports     | Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled. |
|state\_reasons           | Provides the reason for the state change. |
|tags                     | Provides any tags assigned to the image. |
|virtualization\_types    | The type of virtualization of the AMI. |

## Examples

##### Ensure Name of a SSM Parameter exists
    describe aws_ec2_images do
      its('image_ids') { should include 'image-id-43542' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ec2_images.where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_ec2_images.where( <property>: <value>) do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeImages`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).  