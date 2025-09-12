+++
title = "aws_network_firewall_firewalls resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_firewall_firewalls"
identifier = "inspec/resources/aws/aws_network_firewall_firewalls resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_firewall_firewalls` InSpec audit resource to test properties of multiple AWS Network Firewall firewalls.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Firewall Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

## Syntax

Ensure that the firewall exists.

```ruby
describe aws_network_firewall_firewalls do
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

**Ensure a firewall name is available.**

```ruby
describe aws_network_firewall_firewalls do
  its('firewall_names') { should include 'FIREWALL_NAME' }
end
```

**Ensure that the firewall ARN is `FIREWALL_ARN`.**

```ruby
describe aws_network_firewall_firewalls do
    its('firewall_arns') { should include 'FIREWALL_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_firewall_firewalls do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_firewall_firewalls do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_network_firewall_firewalls do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkFirewall:Client:DescribeFirewallResponse" %}}
