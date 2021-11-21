---
title: About the aws_route53resolver_resolver_rules Resource
platform: aws
---

# aws\_route53resolver\_resolver\_rules

Use the `aws_route53resolver_resolver_rules` InSpec audit resource to test properties of multiple AWS Route53 Resolver rules.

The AWS Route53 Resolver Rule resource specifies which Resolver endpoint the queries pass through, one domain name that you want to forward to your network, and the IP addresses of the DNS resolvers in your network.

## Syntax

Ensure that a rule exists.

    describe aws_route53resolver_resolver_rules do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Route53 Resolver Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverrule.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The ID that Resolver assigned to the Resolver rule when you created it. |
| creator_request_ids | A unique string that you specified when you created the Resolver rule. `CreatorRequestId` identifies the request and allows failed requests to be retried without the risk of running the operation twice. |
| arns | The ARN (Amazon Resource Name) for the Resolver rule specified by ID. |
| domain_names | DNS queries for this domain name are forwarded to the IP addresses that are specified in `TargetIps`. |
| statuses | A code that specifies the current status of the Resolver rule. |
| status_messages | A detailed description of the status of a Resolver rule. |
| rule_types | When you want to forward DNS queries for specified domain name to resolvers on your network, specify FORWARD. |
| names | The name for the Resolver rule, which you specified when you created the Resolver rule. |
| target_ips | An array that contains the IP addresses and ports that an outbound endpoint forwards DNS queries to. |
| resolver_endpoint_ids | The ID of the endpoint that the rule is associated with. |
| owner_ids | When a rule is shared with another AWS account, the account ID of the account that the rule is shared with. |
| share_statuses | Whether the rule is shared and, if so, whether the current account is sharing the rule with another account, or another account is sharing the rule with the current account. |
| creation_times | The date and time that the Resolver rule was created, in Unix time format and Coordinated Universal Time (UTC). |
| modification_times | The date and time that the Resolver rule was last updated, in Unix time format and Coordinated Universal Time (UTC). |

## Examples

### Ensure a rule name is available.

    describe aws_route53resolver_resolver_rules do
      its('names') { should include 'RULE_NAME' }
    end

### Ensure that the status is `COMPLETE` or `FAILED`.

    describe aws_route53resolver_resolver_rules do
        its('statuses') { should include 'COMPLETE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53resolver_resolver_rules do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53resolver_resolver_rules do
      it { should_not exist }
    end

### be_available

Use `should` to check if the rule name is available.

    describe aws_route53resolver_resolver_rules do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53Resolver:Client:ListResolverRulesResponse` action with `Effect` set to `Allow`.