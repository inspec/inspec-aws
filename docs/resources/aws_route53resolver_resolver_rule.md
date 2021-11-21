---
title: About the aws_route53resolver_resolver_rule Resource
platform: aws
---

# aws\_route53resolver\_resolver\_rule

Use the `aws_route53resolver_resolver_rule` InSpec audit resource to test properties of a single AWS Route53 Resolver rule.

The AWS Route53 Resolver Rule resource specifies which Resolver endpoint the queries pass through, one domain name that you want to forward to your network, and the IP addresses of the DNS resolvers in your network.

## Syntax

Ensure that a resolver rule exists.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
      it { should exist }
    end

## Parameters

`resolver_rule_id` _(required)_

The ID of the Resolver rule.

For additional information, see the [AWS documentation on AWS Route53 Resolver rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverrule.html).

## Properties

| Property | Description|
| --- | --- |
| id | The ID that Resolver assigned to the Resolver rule when you created it. |
| creator_request_id | A unique string that you specified when you created the Resolver rule. `CreatorRequestId` identifies the request and allows failed requests to be retried without the risk of running the operation twice. |
| arn | The ARN (Amazon Resource Name) for the Resolver rule specified by Id. |
| domain_name | DNS queries for this domain name are forwarded to the IP addresses that are specified in `TargetIps`. |
| status | A code that specifies the current status of the Resolver rule. |
| status_message | A detailed description of the status of a Resolver rule. |
| rule_type | When you want to forward DNS queries for specified domain name to resolvers on your network, specify FORWARD. |
| name | The name for the Resolver rule, which you specified when you created the Resolver rule. |
| target_ips (ip) | One IP address that you want to forward DNS queries to. You can specify only IPv4 addresses. |
| target_ips (port) | The port at the IP address that you want to forward DNS queries to. |
| resolver_endpoint_id | The ID of the endpoint that the rule is associated with. |
| owner_id | When a rule is shared with another AWS account, the account ID of the account that the rule is shared with. |
| share_status | Whether the rule is shared and, if so, whether the current account is sharing the rule with another account, or another account is sharing the rule with the current account. |
| creation_time | The date and time that the Resolver rule was created, in Unix time format and Coordinated Universal Time (UTC). |
| modification_time | The date and time that the Resolver rule was last updated, in Unix time format and Coordinated Universal Time (UTC). |

## Examples

### Ensure a Resolver rule name is available.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
      its('name') { should eq 'ResolverRuleName' }
    end

### Ensure that the status is `COMPLETE` or `FAILED`.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
        its('status') { should eq 'COMPLETE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53Resolver:Client:GetResolverRuleResponse` action with `Effect` set to `Allow`.