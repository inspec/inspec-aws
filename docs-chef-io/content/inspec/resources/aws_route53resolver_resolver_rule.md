+++
title = "aws_route53resolver_resolver_rule Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_route53resolver_resolver_rule"
identifier = "inspec/resources/aws/aws_route53resolver_resolver_rule Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route53resolver_resolver_rule` InSpec audit resource to test properties of a single AWS Route53 Resolver rule.

The AWS Route53 Resolver Rule resource specifies which Resolver endpoint the queries pass through, one domain name that you want to forward to your network, and the IP addresses of the DNS resolvers in your network.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Route53 Resolver rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverrule.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a resolver rule exists.

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
  it { should exist }
end
```

## Parameters

`resolver_rule_id` _(required)_

: The ID of the Resolver rule.

## Properties

`id`
: The ID that Resolver assigned to the Resolver rule when you created it.

`creator_request_id`
: A unique string that you specified when you created the Resolver rule. `CreatorRequestId` identifies the request and allows failed requests to be retried without the risk of running the operation twice.

`arn`
: The ARN (Amazon Resource Name) for the Resolver rule specified by Id.

`domain_name`
: DNS queries for this domain name are forwarded to the IP addresses that are specified in `TargetIps`.

`status`
: A code that specifies the current status of the Resolver rule.

`status_message`
: A detailed description of the status of a Resolver rule.

`rule_type`
: When you want to forward DNS queries for specified domain name to resolvers on your network, specify FORWARD.

`name`
: The name for the Resolver rule, which you specified when you created the Resolver rule.

`target_ips (ip)`
: One IP address that you want to forward DNS queries to. You can specify only IPv4 addresses.

`target_ips (port)`
: The port at the IP address that you want to forward DNS queries to.

`resolver_endpoint_id`
: The ID of the endpoint that the rule is associated with.

`owner_id`
: When a rule is shared with another AWS account, the account ID of the account that the rule is shared with.

`share_status`
: Whether the rule is shared and, if so, whether the current account is sharing the rule with another account, or another account is sharing the rule with the current account.

`creation_time`
: The date and time that the Resolver rule was created, in Unix time format and Coordinated Universal Time (UTC).

`modification_time`
: The date and time that the Resolver rule was last updated, in Unix time format and Coordinated Universal Time (UTC).

## Examples

**Ensure a Resolver rule name is available.**

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
  its('name') { should eq 'ResolverRuleName' }
end
```

**Ensure that the status is `COMPLETE` or `FAILED`.**

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
    its('status') { should eq 'COMPLETE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_route53resolver_resolver_rule(resolver_rule_id: 'RULE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Route53Resolver:Client:GetResolverRuleResponse" %}}
