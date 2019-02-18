require 'helper'
require 'aws_security_group'
require 'aws-sdk-core'

class AwsSecurityGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSecurityGroup.new }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsSecurityGroup.new('rubbish') }
  end

  def test_constructor_expected_well_formed_args
    {
        id: 'sg-1234abcd',
        group_id: 'sg-1234abcd',
        vpc_id: 'vpc-1234abcd',
        group_name: 'some-group',
    }.each do |param, value|
      AwsSecurityGroup.new(param => value, :client_args => { stub_responses: true })
    end
  end

  def test_constructor_expected_well_formed_args_long_hash
    {
        id: 'sg-abcd123454321dcba',
        group_id: 'sg-abcd123454321dcba',
        vpc_id: 'vpc-abcd123454321dcba',
        group_name: 'some-group',
    }.each do |param, value|
      AwsSecurityGroup.new(param => value, :client_args => { stub_responses: true })
    end
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSecurityGroup.new(rubbish: 9) }
  end

  def test_constructor_reject_malformed_args
    {
        id: 'sg-xyz-123',
        group_id: '1234abcd',
        vpc_id: 'vpc_1234abcd',
    }.each do |param, value|
      assert_raises(ArgumentError) { AwsSecurityGroup.new(param => value) }
    end
  end

  def test_security_group_non_existing
    refute AwsSecurityGroup.new(group_id: 'sg-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsSecurityGroupNoRulesTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    security_group[:description] = 'security group with no rules'
    security_group[:group_name] = 'group name'
    security_group[:group_id] = 'sg-1234abcd'
    security_group[:ip_permissions] = []
    security_group[:ip_permissions_egress] = []
    security_group[:vpc_id] = 'vpc-1234abcd'
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-1234abcd', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_exists
    assert @security_group.exists?
  end

  def test_security_group_id
    assert_equal(@security_group.group_id, 'sg-1234abcd')
  end

  def test_security_group_description
    assert_equal(@security_group.description, 'security group with no rules')
  end

  def test_security_group_name
    assert_equal(@security_group.group_name, 'group name')
  end

  def test_security_group_rules_count
    assert_equal(@security_group.inbound_rules_count, 0)
    assert_equal(@security_group.inbound_rules.count, 0)
    assert_equal(@security_group.outbound_rules_count, 0)
    assert_equal(@security_group.outbound_rules.count, 0)
  end

  def test_matcher_allow_criteria_validation
    assert_raises(ArgumentError, "allow should reject unrecognized criteria") { @security_group.allow_in?(shoe_size: 9) }
    [
        :from_port,
        :ipv4_range,
        :port,
        :position,
        :protocol,
        :to_port,
        :security_group,
    ].each do |criterion|
      # No errors here
      @security_group.allow_in?(criterion => 'dummy')
    end
  end

  def test_matcher_allow_inbound_empty
    refute(@security_group.allow_in?())
  end
end

class AwsSecurityGroupInboundRulesTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    security_group[:description] = 'security group with lots of rules'
    security_group[:group_name] = 'group name'
    security_group[:group_id] = 'sg-abcd123454321dcba'
    rule_ssh = {
        from_port: 22,
        to_port: 22,
        ip_protocol: 'tcp',
        ip_ranges: [
            { cidr_ip: "10.1.2.0/24" },
            { cidr_ip: "10.1.3.0/24" },
        ],
        ipv_6_ranges: [
            { cidr_ipv_6: "2001:db8::/122" },
            { cidr_ipv_6: "1968:db8::/124" },
        ],
    }
    rule_all_prot = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        ip_ranges: [
            { cidr_ip: "10.1.4.0/24" },
        ],
        ipv_6_ranges: [
            { cidr_ipv_6: "2018:db8::/122" }
        ]
    }
    rule_udp = {
        from_port: 9001,
        to_port: 9003,
        ip_protocol: "udp",
        ip_ranges: [
            { cidr_ip: "10.2.0.0/16" },
        ]
    }
    security_group[:ip_permissions] = [rule_ssh, rule_all_prot, rule_udp]
    rule_egress = {
        from_port: 123,
        to_port: 123,
        ip_protocol: "udp",
        ip_ranges: [
            { cidr_ip: "128.138.140.44/32" },
        ],
        ipv_6_ranges: [
            { cidr_ipv_6: "2001:db8::/122" }
        ]
    }
    security_group[:ip_permissions_egress] = [rule_egress]
    security_group[:vpc_id] = 'vpc-abcd123454321dcba'
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-1234abcd', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_exists
    assert @security_group.exists?
  end

  def test_security_group_id
    assert_equal(@security_group.group_id, 'sg-abcd123454321dcba')
  end

  def test_security_group_description
    assert_equal(@security_group.description, 'security group with lots of rules')
  end

  def test_security_group_name
    assert_equal(@security_group.group_name, 'group name')
  end

  def test_security_group_rules_count
    assert_equal(@security_group.inbound_rules_count, 7)
    assert_equal(@security_group.inbound_rules.count, 3)
    assert_equal(@security_group.outbound_rules_count, 2)
    assert_equal(@security_group.outbound_rules.count, 1)
  end

  def test_security_group_position_pinning
    assert(@security_group.allow_in?(ipv4_range: "10.1.4.0/24", position: 2), "use numeric position")
    assert(@security_group.allow_in?(ipv4_range: "10.1.4.0/24", position: "2"), "use string position")
    assert(@security_group.allow_in?(ipv4_range: "10.2.0.0/16", position: :last), "use :last position")
    assert(@security_group.allow_in?(port: 22, position: :first), "use :first position")
  end

  def test_security_group_port
    assert(@security_group.allow_in?(port: 22), "match on a numeric port")
    assert(@security_group.allow_in?(port: "22"), "match on a string port")
    assert(@security_group.allow_in?(to_port: "22", from_port: "22"), "match on to/from port")
    assert(@security_group.allow_in?(port: 9002, position: 3), "range matching on port with allow_in")
    refute(@security_group.allow_in_only?(port: 9002, position: 3), "no range matching on port with allow_in_only")
    assert(@security_group.allow_in_only?(from_port: 9001, to_port: 9003, position: 3), "exact range matching on port with allow_in_only")
  end

  def test_security_group_protocol
    assert(@security_group.allow_in?(protocol: 'tcp'), "match on tcp protocol, unpinned")
    assert(@security_group.allow_in?(protocol: 'tcp', position: 1), "match on tcp protocol")
    assert(@security_group.allow_in?(protocol: 'any', position: 2), "match on our 'any' alias protocol")
    assert(@security_group.allow_in?(protocol: '-1', position: 2), "match on AWS spec '-1 for any' protocol")
  end

  def test_security_group_ipv4_range
    assert(@security_group.allow_in?(ipv4_range: ["10.1.4.0/24"]), "match on 1 ipv4 range as array")
    assert(@security_group.allow_in?(ipv4_range: ["10.1.4.33/32"]), "match on 1 ipv4 range subnet membership")
    assert(@security_group.allow_in?(ipv4_range: ["10.1.4.33/32", "10.1.4.82/32"]), "match on 2 addrs ipv4 range subnet membership")
    assert(@security_group.allow_in?(ipv4_range: ["10.1.4.0/25", "10.1.4.128/25"]), "match on 2 subnets ipv4 range subnet membership")
    assert(@security_group.allow_in_only?(ipv4_range: "10.1.4.0/24", position: 2), "exact match on 1 ipv4 range with _only")
    refute(@security_group.allow_in_only?(ipv4_range: "10.1.4.33/32", position: 2), "no range membership ipv4 range with _only")
    assert(@security_group.allow_in?(ipv4_range: "10.1.2.0/24"), "match on a list ipv4 range when providing only one value (first)")
    assert(@security_group.allow_in?(ipv4_range: "10.1.3.0/24"), "match on a list ipv4 range when providing only one value (last)")
    assert(@security_group.allow_in?(ipv4_range: ["10.1.2.33/32", "10.1.3.33/32"]), "match on a list of single IPs against a list of subnets")
    assert(@security_group.allow_in?(ipv4_range: ["10.1.2.0/24", "10.1.3.0/24"]))
    refute(@security_group.allow_in?(ipv4_range: ["10.1.22.0/24", "10.1.33.0/24"]))
    assert(@security_group.allow_in?(ipv4_range: ["10.1.3.0/24", "10.1.2.0/24"])) # Order is ignored
    assert(@security_group.allow_in_only?(ipv4_range: ["10.1.2.0/24", "10.1.3.0/24"], position: 1))
    refute(@security_group.allow_in_only?(ipv4_range: ["10.1.2.0/24"], position: 1))
    refute(@security_group.allow_in_only?(ipv4_range: ["10.1.3.0/24"], position: 1))
  end

  def test_security_group_ipv6_range
    assert(@security_group.allow_in?(ipv6_range: ["2001:db8::/122"]), "match on 1 ipv6 range as array")
    assert(@security_group.allow_in?(ipv6_range: ["2001:db8::20/128"]), "match on 1 ipv6 range subnet membership")
    assert(@security_group.allow_in?(ipv6_range: ["2001:db8::20/128", "2001:db8::3f/128"]), "match on 2 addrs ipv6 range subnet membership")
    assert(@security_group.allow_in?(ipv6_range: ["2001:db8::/128", "1968:db8::/124"]), "match on 2 subnets ipv6 range subnet membership")
    assert(@security_group.allow_in_only?(ipv6_range: "2018:db8::/122", position: 2), "exact match on 1 ipv6 range with _only")
    refute(@security_group.allow_in_only?(ipv6_range: "2001:db8::20/128", position: 2), "no range membership ipv6 range with _only")
  end

  def test_security_group_only_with_no_position
    refute(@security_group.allow_in_only?(port: 22), "_only will fail a multi-rule SG even if it has matching criteria")
    refute(@security_group.allow_in_only?(), "_only will fail a multi-rule SG even if it has match-any criteria")
  end
end

class AwsSecurityGroupSingleRuleGroupIPV4Test < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    rule = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        ip_ranges: [
            { cidr_ip: "0.0.0.0/0" },
        ]
    }
    security_group[:ip_permissions] = [rule]
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-abcd123454321dcba', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_single_ipv4
    assert_equal(1, @security_group.inbound_rules.count, "count the number of rules for 1-rule group")
    assert_equal(1, @security_group.inbound_rules_count, "Count the number of rule variants for 1-rule group")
    assert(@security_group.allow_in_only?(ipv4_range: "0.0.0.0/0"), "Match IP range using _only on 1-rule group")
    assert(@security_group.allow_in_only?(protocol: 'any'), "Match protocol using _only on 1-rule group")
    refute(@security_group.allow_in_only?(port: 22), "no match port using _only on 1-rule group")
  end
end

class AwsSecurityGroupSingleRuleGroupIPV6Test < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    rule = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        ipv_6_ranges: [
            { cidr_ipv_6: "::/0" },
        ]
    }
    security_group[:ip_permissions] = [rule]
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-abcd123454321dcba', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_single_ipv6
    assert_equal(1, @security_group.inbound_rules.count, "count the number of rules for 1-rule ipv6 group")
    assert_equal(1, @security_group.inbound_rules_count, "Count the number of rule variants for 1-rule ipv6 group")
    assert(@security_group.allow_in_only?(ipv6_range: "::/0"), "Match IP range using _only on 1-rule ipv6 group")
    assert(@security_group.allow_in_only?(protocol: 'any'), "Match protocol using _only on 1-rule ipv6 group")
    refute(@security_group.allow_in_only?(port: 22), "no match port using _only on 1-rule ipv6 group")
  end
end

class AwsSecurityGroupAllowAnotherInTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    rule_one = {
        from_port: 80,
        to_port: 443,
        ip_protocol: "-1",
        ip_ranges: [{ cidr_ip: "0.0.0.0/0" }]
    }
    rule_two = {
        from_port: 22,
        to_port: 22,
        ip_protocol: "-1",
        user_id_group_pairs: [{ description: 'Open for group rule 2',
                                group_id: 'sg-33334441' }]
    }
    rule_three = {
        from_port: 9001,
        to_port: 9003,
        ip_protocol: "-1",
        user_id_group_pairs: [{
                                  description: 'Open for group rule 3',
                                  group_id: 'sg-33334441' }]
    }
    security_group[:ip_permissions] = [rule_one, rule_two, rule_three]
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-abcd123454321dcba', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_allow_another
    assert(@security_group.allow_in?(security_group: "sg-33334441"), "match on group-id")
    assert(@security_group.allow_in?(security_group: "sg-33334441", port: 22), "match on group-id, numeric port")
    assert(@security_group.allow_in?(security_group: "sg-33334441", port: "22"), "match on group-id, string port")
    assert(@security_group.allow_in?(security_group: "sg-33334441", to_port: "22", from_port: "22"), "match on group-id, to/from port")
    assert(@security_group.allow_in?(port: 9002, position: 3), "range matching on port with allow_in")
    refute(@security_group.allow_in_only?(port: 9002, position: 3), "no range matching on port with allow_in_only")
    refute(@security_group.allow_in_only?(security_group: "sg-33334441",), "no matching on group with allow_in_only when multiple group rules")
    assert(@security_group.allow_in_only?(from_port: 9001, to_port: 9003, position: 3), "exact range matching on port with allow_in_only")
  end
end

class AwsSecurityGroupAllowSingleTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    rule = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        user_id_group_pairs: [{ description: 'Open for group one rule',
                                group_id: 'sg-33334444' }]
    }
    security_group[:ip_permissions] = [rule]
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-abcd123454321dcba', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_single_rule
    assert_equal(1, @security_group.inbound_rules.count, "count the number of rules for 1-rule security-group")
    assert_equal(1, @security_group.inbound_rules_count, "Count the number of rule variants for 1-rule security-group")
    assert(@security_group.allow_in_only?(security_group: "sg-33334444"), "Match security-group using _only on 1-rule security-group")
    assert(@security_group.allow_in_only?(protocol: 'any', security_group: "sg-33334444"), "Match protocol using _only on 1-rule security-group")
    refute(@security_group.allow_in_only?(port: 22, security_group: "sg-33334444"), "no match port using _only on 1-rule security-group")
  end
end

class AwsSecurityGroupAllowSinglePinnedTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_security_groups
    security_group = {}
    rule_one = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        ipv_6_ranges: [{ cidr_ipv_6: "::/0" }]
    }
    rule_two = {
        from_port: nil,
        to_port: nil,
        ip_protocol: "-1",
        user_id_group_pairs: [
            {
                description: 'Open for group one rule second position',
                group_id: 'sg-33334444'
            }
        ]
    }
    security_group[:ip_permissions] = [rule_one, rule_two]
    data[:data] = { :security_groups => [security_group] }
    data[:client] = Aws::EC2::Client
    @security_group = AwsSecurityGroup.new(id: 'sg-abcd123454321dcba', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_security_group_allow_another_pinned
    assert(@security_group.allow_in_only?(security_group: "sg-33334444", position: 2), "Match security-group using _only with numerical position")
    assert(@security_group.allow_in_only?(protocol: 'any', security_group: "sg-33334444", position: 2), "Match protocol using _only on 1-rule security-group with numerical position")
    refute(@security_group.allow_in_only?(port: 22, security_group: "sg-33334444", position: 2), "no match port using _only on 1-rule security-group with numerical position")
    assert(@security_group.allow_in_only?(security_group: "sg-33334444", position: "2"), "Match security-group using _only with string position")
    assert(@security_group.allow_in_only?(security_group: "sg-33334444", position: :last), "Match security-group using _only with last position")
  end
end