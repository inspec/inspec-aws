+++
title = "aws_route53resolver_resolver_rule_associations resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_route53resolver_resolver_rule_associations"
identifier = "inspec/resources/aws/aws_route53resolver_resolver_rule_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route53resolver_resolver_rule_associations` InSpec audit resource to test properties of multiple AWS Route53 Resolver rule associations.

The Resolver rule association determines which DNS queries that originate in the VPC are forwarded to your network.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Route53Resolver Resolver Rule Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html).

## Syntax

Ensure that a resolver name exists.

```ruby
describe aws_route53resolver_resolver_rule_associations do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The ID of the association between a Resolver rule and a VPC.

`resolver_rule_ids`
: The ID of the Resolver rule that you associated with the VPC that is specified by VPCId.

`names`
: The name of an association between a Resolver rule and a VPC.

`vpc_ids`
: The ID of the VPC that you associated the Resolver rule with.

`statuses`
: A code that specifies the current status of the association between a Resolver rule and a VPC.

`status_messages`
: A detailed description of the status of the association between a Resolver rule and a VPC.

## Examples

**Ensure a resolver name is available.**

```ruby
describe aws_route53resolver_resolver_rule_associations do
  its('names') { should include 'RESOLVER_RULE_NAME' }
end
```

**Ensure that the status is `COMPLETE` or `FAILED`.**

```ruby
describe aws_route53resolver_resolver_rule_associations do
  its('statuses') { should include 'COMPLETE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_route53resolver_resolver_rule_associations do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_route53resolver_resolver_rule_associations do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_athena_work_groups do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Route53Resolver:Client:ListResolverRuleAssociationsResponse" %}}
