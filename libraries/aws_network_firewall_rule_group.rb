# frozen_string_literal: true

require 'aws_backend'

class AWSNetworkFirewallRuleGroup < AwsResourceBase
  name 'aws_network_firewall_rule_group'
  desc 'Returns the data objects for the specified rule group.'

  example "
    describe aws_network_firewall_rule_group(rule_group_name: 'RuleGroupName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { rule_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:rule_group_name])
    raise ArgumentError, "#{@__resource_name__}: rule_group_name must be provided" unless opts[:rule_group_name] && !opts[:rule_group_name].empty?
    @display_name = opts[:rule_group_name]
    catch_aws_errors do
      resp = @aws.network_firewall_client.describe_rule_group({ rule_group_name: opts[:rule_group_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def rule_group_name
    return nil unless exists?
    @res[:rule_group_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Rule Group Name: #{@display_name}"
  end
end
