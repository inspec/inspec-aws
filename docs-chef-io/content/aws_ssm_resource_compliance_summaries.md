+++
title = "aws_ssm_resource_compliance_summaries resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_resource_compliance_summaries"
identifier = "inspec/resources/aws/aws_ssm_resource_compliance_summaries resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_resource_compliance_summaries` InSpec audit resource to test properties of a collection of AWS SSM compliance summaries.

## Syntax

 Ensure you have exactly 3 SSM Resource Compliance Summary Types

```ruby
describe aws_ssm_resource_compliance_summaries do
  its('compliance_types.count') { should cmp 3 }
end
```

## Parameters

`compliance_type` _(optional)_

: This optional parameter allows you to filter based on compliance type. This must be passed as a string `compliance_type: 'value'`.

`overall_severity` _(optional)_

: This optional parameter allows you to filter based on overall severity. This must be passed as a string `overall_severity: 'value'`.

See the [AWS documentation on SSM](https://docs.aws.amazon.com/systems-manager/?id=docs_gateway).

## Properties

`compliance_types`
: Provides the compliance type.

`compliant_summaries`
: Provides a list of items that are compliant for the resource.

`execution_summaries`
: Provides information about the execution.

`non_compliant_summaries`
: Provides a list of items that aren't compliant for the resource.

`overall_severity`
: Provides the highest severity item found for the resource.

`resource_ids`
: Provides the resource id.

`resource_types`
: Provides the resource type.

`status`
: Provides the compliance status for the resource.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_ResourceComplianceSummaryItem.html)

## Examples

**Ensure Compliance Type of a SSM Resource Compliance Summary exists.**

```ruby
describe aws_ssm_resource_compliance_summaries do
  its('compliance_types') { should include 'ssm-compliance-type' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_resource_compliance_summaries.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_ssm_resource_compliance_summaries.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:ListResourceComplianceSummariesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).
