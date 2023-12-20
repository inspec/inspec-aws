+++
title = "aws_route53resolver_resolver_rule_association Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_route53resolver_resolver_rule_association"
identifier = "inspec/resources/aws/aws_route53resolver_resolver_rule_association Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route53resolver_resolver_rule_association` InSpec audit resource to test properties of a single AWS Route53 Resolver rule association.

The Resolver rule association determines which DNS queries that originate in the VPC are forwarded to your network.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Route53Resolver Resolver Rule Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a resolver rule exists.

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  it { should exist }
end
```

## Parameters

`resolver_rule_association_id` _(required)_

: The ID of the Resolver rule association that you want to get information about.

## Properties

`id`
: The ID of the association between a Resolver rule and a VPC.

`resolver_rule_id`
: The ID of the Resolver rule that you associated with the VPC that is specified by VPCId.

`name`
: The name of an association between a Resolver rule and a VPC.

`vpc_id`
: The ID of the VPC that you associated the Resolver rule with.

`status`
: A code that specifies the current status of the association between a Resolver rule and a VPC.

`status_message`
: A detailed description of the status of the association between a Resolver rule and a VPC.

## Examples

**Ensure a resolver rule name is available.**

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  its('name') { should eq 'RESOLVER_RULE_NAME' }
end
```

**Ensure that the status is `COMPLETE` or `FAILED`.**

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  its('status') { should eq 'COMPLETE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'RESOLVER_RULE_ASSOCIATION_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Route53Resolver:Client:GetResolverRuleAssociationResponse" %}}
