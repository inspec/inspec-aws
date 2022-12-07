require 'aws_backend'

class AWSNetworkFirewallFirewall < AwsResourceBase
  name 'aws_network_firewall_firewall'
  desc 'Returns the data objects for the specified firewall.'

  example "
    describe aws_network_firewall_firewall(firewall_name: 'FirewallName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { firewall_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:firewall_name])
    raise ArgumentError, "#{@__resource_name__}: firewall_name must be provided" unless opts[:firewall_name] && !opts[:firewall_name].empty?
    @display_name = opts[:firewall_name]
    catch_aws_errors do
      resp = @aws.network_firewall_client.describe_firewall({ firewall_name: opts[:firewall_name] })
      @res = resp.to_h
      @firewall_arn = @res[:firewall][:firewall_arn]
      create_resource_methods(@res)
    end
  end

  def firewall_name
    return nil unless exists?
    @res[:firewall_name]
  end

  def resource_id
    @firewall_arn
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Firewall Name: #{@display_name}"
  end
end
