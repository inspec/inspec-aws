+++
title = "aws_network_acls resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_acls"
identifier = "inspec/resources/aws/aws_network_acls resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_acls` InSpec audit resource to test the properties of all Amazon network ACLs.
To audit a single network ACL, use the `aws_network_acl` (singular) resource.

## Syntax

An `aws_network_acls` resource block collects a group of network ACL descriptions and then tests that group.

```ruby
describe aws_network_acls
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`network_acl_ids`
: The IDs of all network ACLs.

: **Field**: `network_acl_id`

`vpc_ids`
: The IDs of all the VPCs of the network ACLs.

: **Field**: `vpc_id`

`default`
: The boolean flag to say whether the network ACL is default or not.

: **Field**: `default`

`default_network_acl_ids`
: The default network ACL IDs for all the VPCs.

: **Field**: `default_network_acl_ids`

`associated_subnet_ids`
: The ID of the associated subnets to all the network ACLs.

: **Field**: `associated_subnet_ids`

`network_acl_association_ids`
: The ID of the association between the subnets and the network ACLs.

: **Field**: `network_acl_association_ids`

`entries_cidr_blocks`
: The IPv4 network range to allow or deny, in CIDR notation of all the network ACLs.

: **Field**: `entries_cidr_blocks`

`entries_icmp_type_codes`
: The ICMP code specified in the entry for all the network ACLs.

: **Field**: `entries_icmp_type_codes`

`entries_icmp_type_code_types`
: The ICMP type specified in the entry for all the network ACLs.

: **Field**: `entries_icmp_type_code_types`

`entries_ipv_6_cidr_blocks`
: The IPv6 network range to allow or deny, in CIDR notation of all the network ACLs.

: **Field**: `entries_ipv_6_cidr_blocks`

`entries_port_ranges`
: The ports specified in the entry for all the network ACLs.

: **Field**: `entries_port_ranges`

`entries_protocols`
: The protocol specified in the entry for all the network ACLs.

: **Field**: `entries_protocols`

`entries_rule_actions`
: The rule to allow or deny the matching traffic for all the network ACLs.

: **Field**: `entries_rule_actions`

`entries_rule_numbers`
: The rule number of all ACL entries.

: **Field**: `entries_rule_numbers`

`egress_rule_numbers`
: The rule number of all egress ACL entries.

: **Field**: `egress_rule_numbers`

`ingress_rule_numbers`
: The rule number of all ingress ACL entries.

: **Field**: `ingress_rule_numbers`

`owner_ids`
: The ID of all the AWS accounts that owns all the network ACLs.

: **Field**: `owner_ids`

`tags`
: A hash, with each key-value pair corresponding to a network ACL tag.

: **Field**: `tags`

## Examples

Ensure that exactly three network ACLs exist:

```ruby
describe aws_network_acls do
  its('count') { should eq 3 }
end
```

Filter all network ACLs whose entries have rule number equal to 100:

```ruby
describe aws_network_acls.where { entries_rule_numbers.include?(100) } do
    it { should exist }
end
```

Filter all default network ACLs:

```ruby
describe aws_network_acls.where(default: true) do
    it { should exist }
end
```

Filter all network ACLs with associated subnet IDs matching `subnet-07a323891825bc312`:

```ruby
describe aws_network_acls.where { associated_subnet_ids.include?('subnet-07a323891825bc312') } do
    it { should exist }
end
```

Filter all network ACLs with entries CIDR blocks matching `10.3.0.0/18`:

```ruby
describe aws_network_acls.where { entries_cidr_blocks.include?('10.3.0.0/18') } do
    it { should exist }
end
```

Request the IDs of all network ACLs, then test in-depth using `aws_network_acl`:

```ruby
aws_network_acls.network_acl_ids.each do |network_acl_id|
  describe aws_network_acl(network_acl_id) do
    it { should be_default }
  end
end
```

Request the IDs of all network ACLs for rule number `100`, then test in-depth using `aws_network_acl`:

```ruby
aws_network_acls.where{ ingress_rule_numbers.include?(100) }.network_acl_ids.each do |network_acl_id|
  describe aws_network_acl(network_acl_id) do
    its('egress_rule_number_100.cidr_block') { should eq '10.3.0.0/18' }
    its('egress_rule_number_100.protocol') { should eq '6' }
    its('egress_rule_number_100.rule_action') { should eq 'allow' }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the 'describe' method returns at least one result.

```ruby
describe aws_network_acls.where( <property>: <value>) do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_network_acls.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkAclsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
