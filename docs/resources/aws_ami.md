---
title: About the aws_ami Resource
platform: aws
---

# aws\_ami

Use the `aws_ami` InSpec audit resource to test properties of a single AWS AMI.

## Syntax

An `aws_ami` resource block declares the tests for a single AWS AMI by image id.

    describe aws_ami(image_id: 'aki-2349e94458a507') do
      it { should exist }
    end

#### Parameters

##### image\_id _(required)_

This resource accepts a single parameter, the AMI Image ID.
This can be passed either as a string or as a `image_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on EC2 Amazon Machine Images](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html).


## Properties

|Property                 | Description|
| ---                     | --- |
|architecture             | The architecture of the image. |
|creation\_date           | The date and time the image was created. |
|image\_id                | The ID of the AMI. |
|image\_location          | The location of the AMI. |
|image\_type              | The type of image. |
|public                   | Indicates whether the image has public launch permissions. |
|kernel\_id               | The kernel associated with the image, if any. Only applicable for machine images. |
|owner\_id                | The AWS account ID of the image owner. |
|platform                 | This value is set to windows for Windows AMIs; otherwise, it is blank. |
|platform\_details        | The platform details associated with the billing code of the AMI. |
|usage\_operation         | The operation of the Amazon EC2 instance and the billing code that is associated with the AMI. |
|product\_codes           | Any product codes associated with the AMI. |
|ramdisk\_id              | The RAM disk associated with the image, if any. Only applicable for machine images. |
|state                    | The state of the AMI. |
|block\_device\_mappings  | Any block device mapping entries. |
|description              | The description of the AMI that was provided during image creation. |
|ena\_support             | Specifies whether enhanced networking with ENA is enabled. |
|hypervisor               | The hypervisor type of the image. |
|image\_owner\_alias      | The AWS account alias or the AWS account ID of the AMI owner. |
|name                     | The name of the AMI that was provided during image creation. |
|root\_device\_name       | The device name of the root device volume. |
|root\_device\_type       | The type of root device used by the AMI. |
|sriov\_net\_support      | Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled. |
|state\_reason            | Provides the reason for the state change. |
|tags                     | Provides any tags assigned to the image. |
|virtualization\_type     | The type of virtualization of the AMI. |

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Image.html)

## Examples

##### Check if an AMI is public
    describe aws_ami(image_id: 'aki-25348fd4323') do
      it { should be_public }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### be_public

The `be_public` matcher tests if the AMI has public launch permissons.

    describe aws_ami(image_id: 'aki-1234') do
      it { should be_public }
    end

    describe aws_ami(image_id: 'aki-6789') do
      it { should_not be_public }
    end
   
#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ami(image_id: 'aki-1234') do
      it { should exist }
    end

    describe aws_ami(image_id: 'aki-6789') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeImages` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
