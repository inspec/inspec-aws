require "aws_backend"

class AwsNetworkFirewallFirewallPolicy < AwsResourceBase
  name "aws_network_firewall_firewall_policy"
  desc "Returns the data objects for the specified firewall policy."

  example "
    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { firewall_policy_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:firewall_policy_name])
    unless opts[:firewall_policy_name] && !opts[:firewall_policy_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: firewall_policy_name must be provided"
    end
    @display_name = opts[:firewall_policy_name]
    catch_aws_errors do
      resp =
        @aws.network_firewall_client.describe_firewall_policy(
          { firewall_policy_name: opts[:firewall_policy_name] }
        )
      @res = resp.to_h
      @firewall_policy_arn = @res[:firewall_policy_arn]
      create_resource_methods(@res)
    end
  end

  def firewall_policy_name
    return nil unless exists?
    @res[:firewall_policy_name]
  end

  def resource_id
    @firewall_policy_arn
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Firewall Policy Name: #{@display_name}"
  end
end
