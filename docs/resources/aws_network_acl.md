---
title: About the AWS network ACL Resource
platform: aws
---

# aws_network_acl

Use the `aws_network_acl` InSpec audit resource to test the properties of a single Amazon network ACL.

## Syntax

An `aws_network_acl` resource block declares the tests for a single Amazon network ACL by `network_acl_id`.

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
      it { should exist }
    end

The value of the `network_acl_id` can be provided as a string.

    describe aws_network_acl('acl-001db867a1898981b') do
      it { should exist }
    end

### Parameters

The network ACL ID is required.

#### network\_acl\_id _(required)_

The ID of the network ACL:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `acl-`
- cannot end with a hyphen or contain two consecutive hyphens

It can be passed either as a string or as a `network_acl_id: 'value'` key-value entry in a hash.

## Properties

|Property         | Description                                                    |
| ---             | ---                                                            |
|network\_acl\_id | The ID of the network ACL.                                     |
|is_default       | Indicates whether this is the default network ACL for the VPC. |
|vpc_id           | The ID of the VPC for the network ACL.                         |
|owner_id         | The ID of the AWS account that owns the network ACL.           |
|associated_subnet_ids | The ID of the associated subnets to the network ACL.      |
|egress           | All rules that are applied to traffic leaving the subnet.      |
|ingress          | All rules that are applied to traffic incoming to the subnet.  |
|associations     | All subnet associations on the network ACL.                    |
|tags             | A hash with each key-value pair corresponding to a network ACL. |
|egress_rule_number_*`ACL_RULE_NUMBER`* | This is a dynamically formed property of the egress ACL rule for a specific *`ACL_RULE_NUMBER`*. See below for nested details and examples. |
|ingress_rule_number_*`ACL_RULE_NUMBER`* | This is a dynamically formed property of the ingress ACL rule for a specific *`ACL_RULE_NUMBER`*. See below for nested details and examples. |

## Nested Properties of dynamic egress and ingress rule number properties

|Nested Property     | Description                                                                          |
| ---                | ---                                                                                  |
|cidr_block          | The IPv4 network range to allow or deny, in CIDR notation.                           |
|ipv_6_cidr_block    | The IPv6 network range to allow or deny, in CIDR notation.                           |
|protocol            | The protocol specified in the entry. Accepted values are: `tcp`, `udp`, `icmp`, or a protocol number. |
|rule_action         | Allows or denies the matching traffic. Accepted values are: `allow` or `deny`.       |
|rule_number         | The number of an entry (in other words, rule) in the set of ACL entries.             |
|port_range.from     | The start of the port range specified in the entry.                                  |
|port_range.to       | The end of the port range specified in the entry.                                    |
|icmp_type_cod.code  | The ICMP code specified in the entry, if any.                                        |
|icmp_type_code.type | The ICMP type specified in the entry, if any.                                        |

You can find detailed documentation at [NetworkAclEntry](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/NetworkAclEntry.html)

## Examples

### Test that if a network ACL is default for the VPC

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should be_default }
    end

### Test that the ID of the VPC is `vpc-00727fc4213acee4a`

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        its('vpc_id') { should eq 'vpc-00727fc4213acee4a' }
    end

### Test that the Associated subnet IDs include `subnet-07a323891825bc312`

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        its('associated_subnet_ids') { should include 'subnet-07a323891825bc312' }
    end

### Test that CIDR Block of ACL egress entry for rule number `100` is `10.3.0.0/18`

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        its('egress_rule_number_100.cidr_block') { should eq '10.3.0.0/18' }
    end


### Test that Port Ranges of ACL ingress entry for rule number `100` is `443`

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        its('ingress_rule_number_100.port_range.from') { should eq '443' }
        its('ingress_rule_number_100.port_range.to') { should eq '443' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should exist }
    end

### be_default

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should be_default }
    end

### be_associated (to any subnet)

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should be_associated }
    end

### have_associations

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should have_associations }
        it { should have_associations(subnet_id: 'subnet-07a323891825bc312') }
    end

### have_acl_entry_value

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should have_acl_entry_value(cidr_block: '10.3.0.0/18', egress: false, rule_action: 'allow') }
    end

### have_egress

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should have_egress }
        it { should have_egress(cidr_block: '10.3.0.0/18', rule_action: 'allow') }
        it { should have_egress(rule_action: 'allow') }
        it { should have_egress(cidr_block: '10.3.0.0/18') }
    end

### have_ingress

    describe aws_network_acl(network_acl_id: 'acl-001db867a1898981b') do
        it { should have_ingress }
        it { should have_ingress(cidr_block: '10.3.0.0/18', rule_action: 'allow') }
        it { should have_ingress(rule_action: 'allow') }
        it { should have_ingress(cidr_block: '10.3.0.0/18') }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeNetworkAcls` action set to `allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for network ACL](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
