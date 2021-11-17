---
title: About the aws_route53resolver_resolver_rule_association Resource
platform: aws
---

# aws\_route53resolver\_resolver\_rule\_association

Use the `aws_route53resolver_resolver_rule_association` InSpec audit resource to test properties of a single AWS Route53 Resolver rule association.

The Resolver rule association determines which DNS queries that originate in the VPC are forwarded to your network.

## Syntax

Ensure that a resolver rule exists.

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      it { should exist }
    end

## Parameters

`resolver_rule_association_id` _(required)_

The ID of the Resolver rule association that you want to get information about.

For additional information, see the [AWS documentation on AWS Route53Resolver Resolver Rule Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html).

## Properties

| Property | Description|
| --- | --- |
| id | The ID of the association between a Resolver rule and a VPC. |
| resolver_rule_id | The ID of the Resolver rule that you associated with the VPC that is specified by VPCId. |
| name | The name of an association between a Resolver rule and a VPC. |
| vpc_id | The ID of the VPC that you associated the Resolver rule with. |
| status | A code that specifies the current status of the association between a Resolver rule and a VPC. |
| status_message | A detailed description of the status of the association between a Resolver rule and a VPC. |

## Examples

### Ensure a resolver rule name is available.

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      its('name') { should eq 'RESOLVER_RULE_NAME' }
    end

### Ensure that the status is `COMPLETE` or `FAILED`.

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      its('status') { should eq 'COMPLETE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53Resolver:Client:GetResolverRuleAssociationResponse` action with `Effect` set to `Allow`.
