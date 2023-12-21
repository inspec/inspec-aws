+++
title = "aws_guardduty_detectors Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_guardduty_detectors"
identifier = "inspec/resources/aws/aws_guardduty_detectors Resource"
parent = "inspec/resources/aws"
+++



Use the `aws_guardduty_detectors` InSpec audit resource to test properties of some or all AWS GuardDuty Detectors.

For additional information, including details on parameters and properties, see the [Actions, Resources, and Condition Keys for Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_GetDetector.html).

For additional information, including details on parameters and properties, see the [AWS documentation on GuardDuty Detectors](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html).

## Requirements

Train AWS version 0.1.18 or newer is required for this resource.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 Ensure you have exactly 3 Detectors available to you.

```ruby
describe aws_guardduty_detectors do
  its('detector_ids.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`detector_ids`
: A list of detector IDs.

## Examples

**Ensure GuardDuty Detector ID exists.**

```ruby
describe aws_guardduty_detectors do
  its('detector_ids') { should include ['detector-id-43542'] }
end
```

**Use the InSpec resource to request the IDs of all Detectors, then test in-depth using `aws_guardduty_detector` to ensure all detectors have a six hour publishing frequency.**

```ruby
aws_guardduty_detectors.detector_ids.first.each do |detector_id|
  describe aws_guardduty_detector(detector_id: detector_id) do
    it { should exist }
    its('finding_publishing_frequency') { should eq "SIX_HOURS" }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_guardduty_detectors do
  it { should exist }
end
```

```ruby
describe aws_guardduty_detectors do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="GuardDuty:Client:GetDetectorResponse" %}}
