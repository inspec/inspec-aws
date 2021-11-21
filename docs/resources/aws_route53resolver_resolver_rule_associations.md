---
title: About the aws_route53resolver_resolver_rule_associations Resource
platform: aws
---

# aws\_route53resolver\_resolver\_rule\_associations

Use the `aws_route53resolver_resolver_rule_associations` InSpec audit resource to test properties of multiple AWS Route53 Resolver rule associations.

The Resolver rule association determines which DNS queries that originate in the VPC are forwarded to your network.

## Syntax

Ensure that a resolver name exists.

    describe aws_route53resolver_resolver_rule_associations do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Route53Resolver Resolver Rule Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The ID of the association between a Resolver rule and a VPC. |
| resolver_rule_ids | The ID of the Resolver rule that you associated with the VPC that is specified by VPCId. |
| names | The name of an association between a Resolver rule and a VPC. |
| vpc_ids | The ID of the VPC that you associated the Resolver rule with. |
| statuses | A code that specifies the current status of the association between a Resolver rule and a VPC. |
| status_messages | A detailed description of the status of the association between a Resolver rule and a VPC. |

## Examples

### Ensure a resolver name is available.

    describe aws_route53resolver_resolver_rule_associations do
      its('names') { should include 'RESOLVER_RULE_NAME' }
    end

### Ensure that the status is `COMPLETE` or `FAILED`.

    describe aws_route53resolver_resolver_rule_associations do
      its('statuses') { should include 'COMPLETE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53resolver_resolver_rule_associations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_route53resolver_resolver_rule_associations do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_athena_work_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53Resolver:Client:ListResolverRuleAssociationsResponse` action with `Effect` set to `Allow`.
