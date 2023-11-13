require 'set'
require 'ipaddr'
require 'aws_backend'

class AwsSecurityGroup < AwsResourceBase
  name 'aws_security_group'
  desc 'Verifies settings for an individual AWS Security Group.'
  example "
  describe aws_security_group('sg-12345678') do
    it { should exist }
  end
  "
  attr_reader :description, :group_id, :group_name, :vpc_id, :inbound_rules, :outbound_rules, :inbound_rules_count, :outbound_rules_count, :tags, :resource_data

  def initialize(opts = {})
    opts = { group_id: opts } if opts.is_a?(String)
    opts[:group_id] = opts.delete(:id) if opts.key?(:id) # id is an alias for group_id

    super(opts)

    if !opts.key?(:resource_data)
      validate_parameters(require_any_of: %i(group_id group_name vpc_id))

      filter = []
      if opts.key?(:vpc_id)
        raise ArgumentError, "#{@__resource_name__}: VPC ID must be in the format 'vpc-' followed by 8 or 17 hexadecimal characters." if opts[:vpc_id] !~ /^vpc\-[0-9a-f]{8}|(^vpc\-[0-9a-f]{17})$/
        filter += [{ name: 'vpc-id', values: [opts[:vpc_id]] }]
      end

      if opts.key?(:group_id)
        raise ArgumentError, "#{@__resource_name__}: security group ID must be in the format 'sg-' followed by 8 or 17 hexadecimal characters." if opts[:group_id] !~ /^sg\-[0-9a-f]{8}|(^sg\-[0-9a-f]{17})$/
        filter += [{ name: 'group-id', values: [opts[:group_id]] }]
      end
      filter += [{ name: 'group-name', values: [opts[:group_name]] }] if opts.key?(:group_name)
    end

    if opts.key?(:resource_data)
      if opts[:resource_data].is_a?(Hash)
        @security_group = OpenStruct.new(opts[:resource_data])
      else
        @security_group = opts[:resource_data]
      end

    else
      catch_aws_errors do
        resp = @aws.compute_client.describe_security_groups({ filters: filter })
        if resp.security_groups.empty?
          @inbound_rules = []
          @outbound_rules = []
          @group_id = 'empty response'
          return
        end
        @security_group = resp.security_groups[0]
      end
    end
    @group_id = @security_group.group_id
    @vpc_id   = @security_group.vpc_id
    @description    = @security_group.description
    @group_name     = @security_group.group_name
    @inbound_rules = @security_group.ip_permissions.map(&:to_h)
    @outbound_rules = @security_group.ip_permissions_egress.map(&:to_h)
    @inbound_rules_count = count_sg_rules(@inbound_rules.map(&:to_h))
    @outbound_rules_count = count_sg_rules(@outbound_rules.map(&:to_h))
    @tags = map_tags(@security_group.tags) if @security_group.respond_to?(:tags)
  end

  def allow_in?(criteria = {})
    allow(inbound_rules, criteria.dup)
  end

  RSpec::Matchers.alias_matcher :allow_in, :be_allow_in

  def allow_out?(criteria = {})
    allow(outbound_rules, criteria.dup)
  end

  RSpec::Matchers.alias_matcher :allow_out, :be_allow_out

  def allow_in_only?(criteria = {})
    allow_only(inbound_rules, criteria.dup)
  end

  RSpec::Matchers.alias_matcher :allow_in_only, :be_allow_in_only

  def allow_out_only?(criteria = {})
    allow_only(outbound_rules, criteria.dup)
  end

  RSpec::Matchers.alias_matcher :allow_out_only, :be_allow_out_only

  def exists?
    !@security_group.nil?
  end

  def resource_id
    @group_id
  end

  def to_s
    sg = ''
    sg += "ID: #{@group_id} " if @group_id
    sg += "Name: #{@group_name} " if @group_name
    sg += "VPC ID: #{@vpc_id} " if @vpc_id
    opts.key?(:aws_region) ? "EC2 Security Group: #{sg} in #{opts[:aws_region]}" : "EC2 Security Group #{sg}"
  end

  private

  def allow_only(rules, criteria)
    rules = allow__focus_on_position(rules, criteria)
    # allow_{in_out}_only require either a single-rule group, or you
    # to select a rule using position.
    return false unless rules.count == 1 || criteria.key?(:position)
    if criteria.key?(:security_group)
      if criteria.key?(:position)
        pos = criteria[:position] - 1
      else
        pos = 0
      end
      return false unless rules[pos].key?(:user_id_group_pairs) && rules[pos][:user_id_group_pairs].count == 1
    end
    criteria[:exact] = true
    allow(rules, criteria)
  end

  def allow(rules, criteria)
    criteria = allow__check_criteria(criteria)
    rules = allow__focus_on_position(rules, criteria)

    rules.any? do |rule|
      matched = true
      matched &&= allow__match_port(rule, criteria)
      matched &&= allow__match_protocol(rule, criteria)
      matched &&= allow__match_ipv4_range(rule, criteria)
      matched &&= allow__match_ipv6_range(rule, criteria)
      matched &&= allow__match_security_group(rule, criteria)
      matched
    end
  end

  def allow__check_criteria(raw_criteria)
    allowed_criteria = [
      :from_port,
      :ipv4_range,
      :ipv6_range,
      :security_group,
      :port,
      :position,
      :protocol,
      :to_port,
      :exact, # Internal
    ]
    recognized_criteria = {}
    allowed_criteria.each do |expected_criterion|
      if raw_criteria.key?(expected_criterion)
        recognized_criteria[expected_criterion] = raw_criteria.delete(expected_criterion)
      end
    end

    # Any leftovers are unwelcome
    unless raw_criteria.empty?
      raise ArgumentError, "Unrecognized security group rule 'allow' criteria '#{raw_criteria.keys.join(',')}'. Expected criteria: #{allowed_criteria.join(', ')}"
    end

    recognized_criteria
  end

  def allow__focus_on_position(rules, criteria)
    return rules unless criteria.key?(:position)

    idx = criteria.delete(:position)

    # Normalize to a zero-based numeric index
    case # rubocop: disable Style/EmptyCaseCondition
    when idx.is_a?(Symbol) && idx == :first
      idx = 0
    when idx.is_a?(Symbol) && idx == :last
      idx = rules.count - 1
    when idx.is_a?(String)
      idx = idx.to_i - 1 # We document this as 1-based, so adjust to be zero-based.
    when idx.is_a?(Numeric)
      idx -= 1 # We document this as 1-based, so adjust to be zero-based.
    else
      raise ArgumentError, "#{@__resource_name__}: 'allow' 'position' criteria must be an integer or the symbols :first or :last"
    end

    unless idx < rules.count
      raise ArgumentError, "#{@__resource_name__}: 'allow' 'position' criteria #{idx + 1} is out of range - there are only #{rules.count} rules for security group #{group_id}."
    end

    [rules[idx]]
  end

  def allow__match_port(rule, criteria)
    if criteria[:exact] || criteria[:from_port] || criteria[:to_port]
      # Exact match mode
      # :port is shorthand for a single-valued port range.
      criteria[:to_port] = criteria[:from_port] = criteria[:port] if criteria[:port]
      to = criteria[:to_port]
      from = criteria[:from_port]
      # It's a match if neither criteria was specified
      return true if to.nil? && from.nil?
      # Normalize to integers
      to = to.to_i unless to.nil?
      from = from.to_i unless from.nil?
      # It's a match if either was specified and the other was not
      return true if rule[:to_port] == to && from.nil?
      return true if rule[:from_port] == from && to.nil?
      # Finally, both must match.
      rule[:to_port] == to && rule[:from_port] == from
    elsif !criteria[:port]
      # port not specified, match anything
      true
    else
      # Range membership mode
      rule_from = rule[:from_port] || 0
      rule_to = rule[:to_port] || 65535
      (rule_from..rule_to).cover?(criteria[:port].to_i)
    end
  end

  def allow__match_protocol(rule, criteria)
    return true unless criteria.key?(:protocol)
    prot = criteria[:protocol]
    # We provide a "fluency alias" for -1 (any).
    prot = '-1' if prot == 'any' or prot.casecmp?('all')

    rule[:ip_protocol] == prot
  end

  def match_ipv4_or_6_range(rule, criteria)
    if criteria.key?(:ipv4_range)
      query = criteria[:ipv4_range]
      query = Array(query)
      ranges = rule[:ip_ranges].map { |rng| rng[:cidr_ip] }
    else # IPv6
      query = criteria[:ipv6_range]
      query = Array(query)
      ranges = rule[:ipv_6_ranges].map { |rng| rng[:cidr_ipv_6] }
    end

    if criteria[:exact]
      Set.new(query) == Set.new(ranges)
    else
      # CIDR subset mode
      # "Each of the provided IP ranges must be a member of one of the rule's listed IP ranges"
      query.all? do |candidate|
        candidate = IPAddr.new(candidate)
        ranges.any? do |range|
          range = IPAddr.new(range)
          range.include?(candidate)
        end
      end
    end
  end

  def allow__match_ipv4_range(rule, criteria)
    return true unless criteria.key?(:ipv4_range)
    match_ipv4_or_6_range(rule, criteria)
  end

  def allow__match_ipv6_range(rule, criteria)
    return true unless criteria.key?(:ipv6_range)
    match_ipv4_or_6_range(rule, criteria)
  end

  def allow__match_security_group(rule, criteria)
    return true unless criteria.key?(:security_group)
    query = criteria[:security_group]
    return false unless rule[:user_id_group_pairs]
    rule[:user_id_group_pairs].any? { |group| query == group[:group_id] }
  end

  def count_sg_rules(ip_permissions)
    rule_count = 0
    ip_permissions.each do |ip_permission|
      %i(ip_ranges ipv_6_ranges user_id_group_pairs).each do |key|
        if ip_permission.key? key
          rule_count += ip_permission[key].length
        end
      end
    end
    rule_count
  end
end
