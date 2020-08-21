---
title: About the aws_ssm_resource_compliance_summary Resource
platform: aws
---

# aws\_ssm\_resource\_compliance\_summary

Use the `aws_ssm_resource_compliance_summary` InSpec audit resource to test properties of a ssm resource compliance summary.

## Syntax

 An `aws_ssm_resource_compliance_summary` resource block uses the parameter to select a ssm resource compliance summary.

    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id-1234') do
      it { should exist }
    end


#### Parameters

##### resource_id _(required)_

This resource requires the SSM Resource ID parameter.
This can be passed either as a string or as a `resource_id: 'value'` key-value entry in a hash.

##### compliance_type _(optional)_

This optional parameter allows you to filter based on resource_id and compliance type together. This must be passed as a string `compliance_type: 'value'`.

##### overall_severity _(optional)_

This optional parameter allows you to filter based on resource_id and overall severity together. This must be passed as a string `overall_severity: 'value'`.

##### status _(optional)_

This optional parameter allows you to filter based on resource_id and status together. This must be passed as a string `status: 'value'`.

See also the [AWS documentation on SSM Resource Compliance Summary](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-compliance-about.html#compliance-view-results).


## Properties

|Property                     | Description|
| ---                         | --- |
|compliance_type              | Provides the compliance type. |
|compliant_summary            | Provides a list of items that are compliant for the resource. |
|execution_summary            | Provides information about the execution |
|non_compliant_summary        | Provides a list of items that aren't compliant for the resource. |
|overall_severity             | Provides the highest severity item found for the resource. |
|resource_id                  | Provides the resource id. |
|resource_type                | Provides the resource type. |
|status                       | Provides the compliance status for the resource. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_ResourceComplianceSummaryItem.html)

## Examples

##### Check the Status of a SSM Resource Compliance Summary

    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id-1234', status: 'status-1234') do
      it { should exist }
      its('resource_id')    { should include resource_id }
      its('status')         { should include 'status-1234' }
    end
    
##### Return specific Compliance type for a SSM Resource Compliance Summary
   
    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id-1234', compliance_type: 'compliance-type-1234') do
      it { should exist }
      its('resource_id')      { should include resource_id }
      its('compliance_type')  { should include 'compliance-type-1234' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id-1234') do
      it { should exist }
    end

    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id-6789') do
      it { should_not exist }
    end

## AWS Permissions
Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:ListResourceComplianceSummaries` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).