+++
title = "aws_guardduty_detector resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_guardduty_detector"
identifier = "inspec/resources/aws/aws_guardduty_detector resource"
parent = "inspec/resources/aws"
+++

Use the `aws_guardduty_detector` InSpec audit resource to test properties of a single AWS GuardDuty Detector.

For additional information, including details on parameters and properties, see the [Actions, Resources, and Condition Keys for Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_GetDetector.html).

For additional information, including details on parameters and properties, see the [AWS documentation on GuardDuty Detectors](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html).

## Requirements

Train AWS version 0.1.18 or newer is required for this resource.

## Syntax

An `aws_guardduty_detector` resource block declares the tests for a single AWS GuardDuty Detector by detector id.

```ruby
describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
  it { should exist }
end
```

## Parameters

`detector_id` _(required)_

: This resource accepts a single parameter, the GuardDuty Detector ID.
  This can be passed either as a string or as a `detector_id: 'value'` key-value entry in a hash.

## Properties

`created_at`
: The timestamp of when the detector was created.

`data_sources`
: An object that describes which data sources are enabled for the detector.

`finding_publishing_frequency`
: The publishing frequency of the finding.

`service_role`
: The GuardDuty service role.

`status`
: The detector status. Status should be either ENABLED or DISABLED.

`tags`
: The tags of the detector resource.

`updated_at`
: The last-updated timestamp for the detector.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_GetDetector.html)

## Examples

Check the publishing frequency of a Detector:

```ruby
describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
  its('finding_publishing_frequency') { should eq "SIX_HOURS" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_enabled

The `be_enabled` matcher tests if the status of the detector is enabled.

```ruby
describe aws_guardduty_detector(detector_id: 'detector-id-1234') do
  it { should be_enabled }
end
```

```ruby
describe aws_guardduty_detector(detector_id: 'detector-id-6789') do
  it { should_not be_enabled }
end
```

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_guardduty_detector(detector_id: '12abc34d567e8fa901bc2d34e56789f0') do
  it { should exist }
end
```

```ruby
describe aws_guardduty_detector(detector_id: '809abz34d567e8fa91bc2d34e56789f5') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="GuardDuty:Client:GetDetectorResponse" %}}
