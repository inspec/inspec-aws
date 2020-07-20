---
title: About the aws_ssm_compliance_summaries Resource
platform: aws
---

# aws\_ssm\_compliance\_summaries

Use the `aws_ssm_compliance_summaries` InSpec audit resource to test properties of a collection of AWS SSM compliance summaries.

## Syntax

 Ensure you have exactly 3 SSM Compliance Summary Types

    describe aws_ssm_compliance_summaries do
      its('compliance_types.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on SSM](https://docs.aws.amazon.com/systems-manager/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|compliant_count              | Provides the total number of resources that are compliant. |
|severity_summary             | Provides a summary of the compliance severity by compliance type. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_CompliantSummary.html)

## Examples

##### Ensure Compliance Type of a SSM Compliance Summary exists
    describe aws_ssm_compliance_summaries do
      its('compliance_type') { should include 'ssm-compliance-type' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_compliance_summaries.where( <property>: <value> ) do
      it { should exist }
    end

    describe aws_ssm_compliance_summaries.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:ListComplianceSummaries` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).