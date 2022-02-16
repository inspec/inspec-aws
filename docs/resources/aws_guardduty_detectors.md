---
title: About the aws_guardduty_detectors Resource
platform: aws
---



# aws\_guardduty\_detectors

Use the `aws_guardduty_detectors` InSpec audit resource to test properties of some or all AWS GuardDuty Detectors.

For additional information, including details on parameters and properties, see the [Actions, Resources, and Condition Keys for Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_GetDetector.html).

## Requirements

Train AWS version 0.1.18 or newer is required for this resource.

## Syntax

 Ensure you have exactly 3 Detectors available to you.

    describe aws_guardduty_detectors do
      its('detector_ids.count') { should cmp 3 }
    end

## Parameters

This resource does not require any required parameters.

See also the [AWS documentation on GuardDuty Detectors](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
|detector_ids             | A list of detector IDs. |

## Examples

##### Ensure GuardDuty Detector ID exists

    describe aws_guardduty_detectors do
      its('detector_ids') { should include ['detector-id-43542'] }
    end

##### Use the InSpec resource to request the IDs of all Detectors, then test in-depth using `aws_guardduty_detector` to ensure all detectors have a six hour publishing frequency.

    aws_guardduty_detectors.detector_ids.first.each do |detector_id|
      describe aws_guardduty_detector(detector_id: detector_id) do
        it { should exist }
        its('finding_publishing_frequency') { should eq "SIX_HOURS" }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_guardduty_detectors do
      it { should exist }
    end

    describe aws_guardduty_detectors do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `GuardDuty:Client:GetDetectorResponse` action with `Effect` set to `Allow`.
