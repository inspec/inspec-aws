require 'aws_backend'

class AWSNetworkFirewallRuleGroup < AwsResourceBase
  name 'aws_network_firewall_rule_group'
  desc 'Returns the data objects for the specified rule group.'

  example "
    describe aws_network_firewall_rule_group(rule_group_arn: 'RuleGroupName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { rule_group_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:rule_group_arn])
    raise ArgumentError, "#{@__resource_name__}: rule_group_arn must be provided" unless opts[:rule_group_arn] && !opts[:rule_group_arn].empty?
    @display_name = opts[:rule_group_arn]
    catch_aws_errors do
      resp = @aws.network_firewall_client.describe_rule_group({ rule_group_arn: opts[:rule_group_arn] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def rule_group_arn
    return unless exists?
    @res[:rule_group_arn]
  end

  def resource_id
    @res? @res[:rule_group_response][:rule_group_arn]: @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Rule Group ARN: #{@display_name}"
  end
end
