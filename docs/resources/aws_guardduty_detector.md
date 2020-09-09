---
title: About the aws_guardduty_detector Resource
platform: aws
---

# Requirements

Train AWS version 0.1.18 or newer is required for this resource.

# aws\_ami

Use the `aws_guardduty_detector` InSpec audit resource to test properties of a single AWS GuardDuty Detector.

## Syntax

An `aws_guardduty_detector` resource block declares the tests for a single AWS GuardDuty Detector by detector id.

    describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
      it { should exist }
    end

#### Parameters

##### detector\_id _(required)_

This resource accepts a single parameter, the GuardDuty Detector ID.
This can be passed either as a string or as a `detector_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on GuardDuty Detectors](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html).


## Properties

|Property                       | Description|
| ---                           | --- |
|detector\_id                   | The unique ID of the detector that you want to get. |
|created\_at                    | The timestamp of when the detector was created. |
|data\_sources                  | An object that describes which data sources are enabled for the detector. |
|finding\_publishing\_frequency | The publishing frequency of the finding. |
|service\_role                  | The GuardDuty service role. |
|status                         | The detector status. |
|tags                           | The tags of the detector resource. |
|updated\_at                    | The last-updated timestamp for the detector. |

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Image.html)

## Examples

##### Check if a Dectector exists
    describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
      it { should exist }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).
   
#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
      it { should exist }
    end

    describe aws_guardduty_detector(detector_id: '809abz34d567e8fa91bc2d34e56789f5') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `guardduty:GetDetector`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html).  
