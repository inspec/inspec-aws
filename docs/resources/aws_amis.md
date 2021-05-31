---
title: About the aws_amis Resource
platform: aws
---

# aws\_amis

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
    
#### Parameters

This resource must be provided with the parameter 'all_amis' (returns ALL AMIs available to you) OR a combination of the following.

##### all_amis _(optional)_

_OR_

##### architecture _(optional)_
##### creation\_date _(optional)_
##### image\_id _(optional)_
##### image\_type _(optional)_
##### is\_public _(optional)_
##### kernel\_id _(optional)_
##### owner\_id _(optional)_
##### owners _(optional)_
    - Scopes the results to images with the specified owners. You can specify a combination of AWS account IDs, `self`, `amazon`, and `aws-marketplace`. 
    If you omit this parameter, the results include all images for which you have launch permissions, regardless of ownership.
##### owner\_alias _(optional)_
##### platform _(optional)_
##### product\_code _(optional)_
##### platform\_details _(optional)_
##### usage\_operation _(optional)_
##### ramdisk\_id _(optional)_
##### state _(optional)_
##### state\_reason\_code _(optional)_
##### state\_reason\_message _(optional)_
##### description _(optional)_
##### ena\_support _(optional)_
##### hypervisor _(optional)_
##### name _(optional)_
##### root\_device\_name _(optional)_
##### root\_device\_type _(optional)_
##### sriov\_net\_support _(optional)_
##### virtualization\_type _(optional)_

This can be passed either as a string or as a `all_amis: 'value'` key-value entry in a hash.

## Properties

|Property                 | Description|
| ---                     | --- |
|architectures            | The architecture of the image. |
|creation\_dates          | The date and time the image was created. |
|image\_ids               | The ID of the AMI. |
|image\_locations         | The location of the AMI. |
|image\_types             | The type of image. |
|public                   | Indicates whether the image has public launch permissions. |
|kernel\_ids              | The kernel associated with the image, if any. Only applicable for machine images. |
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
|hypervisors               | The hypervisor type of the image. |
|image\_owner\_alias      | The AWS account alias or the AWS account ID of the AMI owner. |
|names                    | The name of the AMI that was provided during image creation. |
|root\_device\_names      | The device name of the root device volume. |
|root\_device\_types      | The type of root device used by the AMI. |
|sriov\_net\_supports     | Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is enabled. |
|state\_reasons           | Provides the reason for the state change. |
|tags                     | Provides any tags assigned to the image. |
|virtualization\_types    | The type of virtualization of the AMI. |

## Examples

##### Ensure ID of an AMI exists
    describe aws_amis(all_amis: 'true') do
      its('image_ids') { should include 'image-id-43542' }
    end
    
##### Interrogate AMIs Belong to the Current User Only
    describe aws_amis(owners: 'self') do
      its('owner_ids.uniq.size') { should be 1 }
      its('owner_ids.uniq.first') { should eq 12345678 }
    end
        
##### Interrogate AMIs Belong to the Current User and the Amazon
    describe aws_amis(owners: ['self', 'amazon']) do
      it { should exist }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_amis(all_amis: 'true').where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_amis(all_amis: 'true').where( <property>: <value>) do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeImages`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).  