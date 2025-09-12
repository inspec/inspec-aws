+++
title = "aws_network_firewall_firewall_policies resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_firewall_firewall_policies"
identifier = "inspec/resources/aws/aws_network_firewall_firewall_policies resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_firewall_firewall_policies` InSpec audit resource to test properties of multiple AWS Network Firewall Policy.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Firewall Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

## Syntax

Ensure that the policy exists.

```ruby
describe aws_network_firewall_firewall_policies do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`firewall_names`
: The descriptive name of the firewall.

: **Field**: `firewall_name`

`firewall_arns`
: The Amazon Resource Name (ARN) of the firewall.

: **Field**: `firewall_arn`

## Examples

**Ensure a policy name is available.**

```ruby
describe aws_network_firewall_firewall_policies do
  its('names') { should include 'FIREWALL_NAME' }
end
```

**Ensure that the policy arn is available.**

```ruby
describe aws_network_firewall_firewall_policies do
    its('arns') { should include 'POLICY_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `List` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_firewall_firewall_policies do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_firewall_firewall_policies do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkFirewall:Client:ListFirewallPoliciesResponse" %}}
