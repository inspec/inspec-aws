---
title: About the aws_security_group Resource
---

# aws\_security\_group

Use the `aws_security_group` InSpec audit resource to test detailed properties of an individual Security Group (SG).

SGs are a networking construct which contain ingress and egress rules for network communications.  SGs may be attached to EC2 instances, as well as certain other AWS resources.  Along with Network Access Control Lists, SGs are one of the two main mechanisms of enforcing network-level security.

## Limitations

While this resource provides facilities for searching inbound and outbound rules on a variety of criteria, there is currently no support for performing matches based on:

 * References to VPC peers or other AWS services (that is, no support for searches based on 'prefix lists').

<br>

## Syntax

Resource parameters: group_id, group_name, id, vpc_id

An `aws_security_group` resource block uses resource parameters to search for and then test a Security Group. If no SGs match, no error is raised, but the `exists` matcher returns `false`, and all scalar properties are `nil`. List properties returned under these conditions are empty lists. If more than one SG matches (due to vague search parameters), an error is raised.

    # Ensure you have a Security Group with a specific ID
    # This is "safe" - SG IDs are unique within an account
    describe aws_security_group('sg-12345678') do
      it { should exist }
    end

    # Ensure you have a Security Group with a specific ID
    # This uses hash syntax
    describe aws_security_group(id: 'sg-12345678') do
      it { should exist }
    end

    # Ensure you have a Security Group with a specific name.  Names are
    # unique within a VPC but not across VPCs.
    # Using only Group returns an error if multiple SGs match.
    describe aws_security_group(group_name: 'my-group') do
      it { should exist }
    end
    # Add vpc_id to ensure uniqueness.
    describe aws_security_group(group_name: 'my-group', vpc_id: 'vpc-12345678') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Ensure that the linux_servers Security Group permits
    # SSH from the 10.5.0.0/16 range, but not the world.
    describe aws_security_group(group_name: linux_servers) do
      # This passes if any inbound rule exists that specifies
      # port 22 and the given IP range, regardless of protocol, etc.
      it { should allow_in(port: 22, ipv4_range: '10.5.0.0/16') }

      # This passes so long as no inbound rule that specifies port 22 exists
      # with a source IP range of 0.0.0.0/0.  Other properties are ignored.
      it { should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0') }

    end

    # Ensure that the careful_updates Security Group may only initiate contact with specific IPs.
    describe aws_security_group(group_name: 'careful_updates') do

      # If you have two rules, with one CIDR each:
      [ '10.7.23.12/32', '10.8.23.12/32' ].each do |allowed_destination|
        # This doesn't care about which ports are enabled
        it { should allow_out(ipv4_range: allowed_destination) }
      end

      # If you have one rule with two CIDRs:
      it { should allow_out(ipv4_range: [ '10.7.23.12/32', '10.8.23.12/32' ]) }

      # Expect exactly three rules.
      its('outbound_rules.count') { should cmp 3 }
    end

    # Ensure that the canary_deployments Security Group only allows access from one specific security group id on port 443.
    describe aws_security_group(group_name: 'canary_deployments') do

      it { should allow_in_only(port: 443, security_group: "sg-33334444") }
    end

    # Ensure that one of the security groups in a list allows access from one of the groups in another list.
    # If you have two lists of groups, check if one of the groups in the first list allows access for one of the
    # groups in the second list.

      control 'master to node access security group' do
        desc 'one of the node security groups should allow all access from:
      one of the master security groups, so masters can reach all nodes'
        describe.one do
          [ 'sg-11112222', 'sg-33334444' ].each do |nodeSG|
            [ 'sg-55556666', 'sg-77778888' ].each do |masterSG|
              describe aws_security_group(id: nodeSG) do
                it { should allow_in(security_group: masterSG) }
              end
            end
          end
        end
      end

<br>

## Resource Parameters

This InSpec resource accepts the following parameters, which are used to search for the Security Group.

### id, group\_id

The Security Group ID of the Security Group. This is of the format `sg-` followed by 8 hexadecimal characters.  The ID is unique within your AWS account; using ID ensures a match of only one SG. The ID is also the default resource parameter, so you may omit the hash syntax.

    # Using Hash syntax
    describe aws_security_group(id: 'sg-12345678') do
      it { should exist }
    end

    # group_id is an alias for id
    describe aws_security_group(group_id: 'sg-12345678') do
      it { should exist }
    end

    # Or omit hash syntax, rely on it being the default parameter
    describe aws_security_group('sg-12345678') do
      it { should exist }
    end

### group\_name

The string name of the Security Group.  Every VPC has a Security Group named 'default'. Names are unique within a VPC, but not within an AWS account.

    # Get default Security Group for a specific VPC
    describe aws_security_group(group_name: 'default', vpc_id: vpc_id: 'vpc-12345678') do
      it { should exist }
    end

    # This throws an error if more than one VPC has a 'backend' SG.
    describe aws_security_group(group_name: 'backend') do
      it { should exist }
    end

### vpc\_id

A string identifying the VPC that contains the Security Group. Since VPCs commonly contain many SGs, you should add additional parameters to ensure you find exactly one SG.

    # This throws an error if more than the default SG exists
    describe aws_security_group(vpc_id: 'vpc-12345678') do
      it { should exist }
    end

<br>
## Properties

* [`description`](#description), [`group_id`](#group_id), [`group_name`](#group_name), [`inbound_rules`](#inbound_rules), [`inbound_rules_count`](#inbound_rules_count), [`outbound_rules`](#outbound_rules), [`outbound_rules_count`](#outbound_rules_count), [`vpc_id`](#vpc_id)

<br>

## Property Examples

### description

A String reflecting the human-meaningful description that was given to the SG at creation time.

    # Require a description of a particular Security Group
    describe aws_security_group('sg-12345678') do
      its('description') { should_not be_empty }
    end

### group\_id

Provides the Security Group ID.

    # Inspect the Security group ID of the default Group
    describe aws_security_group(group_name: 'default', vpc_id: vpc_id: 'vpc-12345678') do
      its('group_id') { should cmp 'sg-12345678' }
    end

    # Store the Group ID in a Ruby variable for use elsewhere
    sg_id = aws_security_group(group_name: 'default', vpc_id: vpc_id: 'vpc-12345678').group_id

### group\_name

A String reflecting the name that was given to the SG at creation time.

    # Inspect the Group name of a particular Group
    describe aws_security_group('sg-12345678') do
      its('group_name') { should cmp 'my_group' }
    end

### inbound\_rules

A list of the rules that the Security Group applies to incoming network traffic. This is a low-level property that is used by the [`allow_in`](#allow_in) and [`allow_in_only`](#allow_in_only) matchers; see them for detailed examples. `inbound_rules` is provided here for those wishing to use Ruby code to inspect the rules directly, instead of using higher-level matchers.

Order is critical in these rules, as the sequentially first rule to match is applied to network traffic. By default, AWS includes a reject-all rule as the last inbound rule.  This implicit rule does not appear in the inbound_rules list.

If the Security Group could not be found (that is, `exists` is false), `inbound_rules` returns an empty list.

    describe aws_security_group(group_name: linux_servers) do
      its('inbound_rules.first') { should include(from_port: '22', ip_ranges: ['10.2.17.0/24']) }
    end

### inbound\_rules\_count

A Number totalling the number of individual rules defined - It is a sum of the combinations of port, protocol, ipv4 rules, ipv6 rules and security group rules.

    describe aws_security_group(group_name: linux_servers) do
      its('inbound_rules_count'){ should eq 10 }
    end

### outbound\_rules

A list of the rules that the Security Group applies to outgoing network traffic initiated by the AWS resource in the Security Group. This is a low-level property that is used by the [`allow_out`](#allow_out) matcher; see it for detailed examples. `outbound_rules` is provided here for those wishing to use Ruby code to inspect the rules directly, instead of using higher-level matchers.

Order is critical in these rules, as the sequentially first rule to match is applied to network traffic. Outbound rules are typically used when it is desirable to restrict which portions of the internet, if any, a resource may access. By default, AWS includes an allow-all rule as the last outbound rule; note that Terraform removes this implicit rule.

If the Security Group could not be found (that is, `exists` is false), `outbound_rules` returns an empty list.

    describe aws_security_group(group_name: isolated_servers) do
      its('outbound_rules.last') { should_not include(ip_ranges:['0.0.0.0/0']) }
    end

### outbound\_rules\_count

A Number totalling the number of individual rules defined - It is a sum of the combinations of port, protocol, ipv4 rules, ipv6 rules and security group rules.

    describe aws_security_group(group_name: linux_servers) do
      its('outbound_rules_count'){ should eq 2 }
    end

### vpc\_id

A String in the format 'vpc-' followed by 8 hexadecimal characters reflecting VPC that contains the Security Group.

    # Inspect the VPC ID of a particular Group
    describe aws_security_group('sg-12345678') do
      its('vpc_id') { should cmp 'vpc-12345678' }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of additional available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

* [`allow_in`](#allow_in), [`allow_in_only`](#allow_in_only), [`allow_out`](#allow_out), [`allow_out_only`](#allow_out_only)

### allow\_in

### allow\_out

### allow\_in\_only

### allow\_out\_only

The `allow` series of matchers enable you to perform queries about what network traffic would be permitted through the Security Group rule set.

`allow_in` and `allow_in_exactly` examine inbound rules, and `allow_out` and `allow_out_exactly` examine outbound rules.

`allow_in` and `allow_out` examine if at least one rule that matches the criteria exists. `allow_in` and `allow_out` also perform inexact (ie, range-based or subset-based) matching on ports and IP addresses ranges, allowing you to specify a candidate port or IP address and determine if it is covered by a rule.

`allow_in_only` and `allow_out_only` examines if exactly one rule exists (but see `position`, below), and if it matches the criteria (this is useful for ensuring no unexpected rules have been added). Additionally, `allow_in_only` and `allow_out_only` do _not_ perform inexact matching; you must specify exactly the port range or IP address(es) you wish to match.

The matchers accept a key-value list of search criteria.  For a rule to match, it must match all provided criteria.

  * from_port - Determines if a rule exists whose port range begins at the specified number. The word 'from_' does *not* relate to inbound/outbound directionality; it relates to the port range ("counting _from_"). `from_port` is an exact criterion; so if the rule allows 1000-2000 and you specify a `from_port` of 1001, it does not match.
  * ipv4_range - Specifies an IPv4 address or subnet as a CIDR, or a list of them, to be checked as a permissible origin (for `allow_in`) or destination (for `allow_out`) for traffic.  Each AWS Security Group rule may have multiple allowed source IP ranges.
  * ipv6_range - Specifies an IPv6 address or subnet as a CIDR, or a list of them, to be checked as a permissible origin (for `allow_in`) or destination (for `allow_out`) for traffic.  Each AWS Security Group rule may have multiple allowed source IP ranges.
  * port - Determines if a particular TCP/IP port is reachable. allow_in and allow_out examine whether the specified port is included in the port range of a rule, while allow_in. You may specify the port as a string (`'22'`) or as a number.
  * position - A one-based index into the list of rules. If provided, this restricts the evaluation to the rule at that position. You may also use the special values `:first` and `:last`. `position` may also be used to enable `allow_in_only` and `allow_out_only` to work with multi-rule Security Groups.
  * protocol - Specifies the IP protocol. 'tcp', 'udp', and 'icmp' are some typical values. The string "-1" or 'any' is used to indicate any protocol.
  * to_port - Determines if a rule exists whose port range ends at the specified number. The word 'to_' does *not* relate to inbound/outbound directionality; it relates to the port range ("counting _to_"). `to_port` is an exact criterion; so if the rule allows 1000-2000 and you specify a `to_port` of 1999, it does not match.
  * security_group - Specifies a security-group id, to be checked as permissible origin (for `allow_in`) or destination (for `allow_out`) for traffic. Each AWS Security Group rule may have multiple allowed source or destination security groups.

    describe aws_security_group(group_name: 'mixed-functionality-group') do
      # Allow RDP from defined range
      it { should allow_in(port: 3389, ipv4_range: '10.5.0.0/16') }
      it { should allow_in(port: 3389, ipv6_range: '2001:db8::/122') }

      # Allow SSH from two ranges
      it { should allow_in(port: 22, ipv4_range: ['10.5.0.0/16', '10.2.3.0/24']) }

      # Check Bacula port range
      it { should allow_in(from_port: 9101, to_port: 9103, ipv4_range: '10.6.7.0/24') }

      # Assuming the AWS SG allows 9001-9003, use inexact matching to check 9002
      it { should allow_in(port: 9002) }

      # Assuming the AWS SG allows 10.2.1.0/24, use inexact matching to check 10.2.1.33/32
      it { should allow_in(ipv4_range: '10.2.1.33/32') }

      # Ensure the 3rd outbound rule is TCP-based
      it { should allow_in(protocol: 'tcp', position: 3') }

      # Do not allow unrestricted IPv4 access.
      it { should_not allow_in(ipv4_range: '0.0.0.0/0') }

      # Allow unrestricted access from security-group.
      it { should allow_in(security_group: 'sg-11112222') }
    end

    # Suppose you have a Group that should allow SSH and RDP from
    # the admin network, 10.5.0.0/16. The resource has 2 rules to
    # allow this, and you want to ensure no others have been added.
    describe aws_security_group(group_name: 'admin-group') do
      # Allow RDP from a defined range and nothing else
      # The SG must have this rule in position 1 and it must match this exactly
      it { should allow_in_only(port: 3389, ipv4_range: '10.5.0.0/16', position: 1) }

      # Specify position 2 for the SSH rule.  Without `position`,
      # allow_in_only only allows one rule, total.
      it { should allow_in_only(port: 22, ipv4_range: '10.5.0.0/16', position: 2) }

      # Because this is an _only matcher, this fails - _only matchers
      # use exact IP matching.
      it { should allow_in_only(port: 3389, ipv4_range: '10.5.1.34/32', position: 1) }
    end

### exists

The control passes if the specified Security Group was found.  Use `should_not` if you want to verify that the specified SG does not exist.

    # You always have at least one SG, the VPC default SG
    describe aws_security_group(group_name: 'default')
      it { should exist }
    end

    # Make sure we don't have any Security Groups with the name 'nogood'
    describe aws_security_group(group_name: 'nogood')
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeSecurityGroups` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
