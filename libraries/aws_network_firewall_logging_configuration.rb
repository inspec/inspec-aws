require 'aws_backend'

class AWSNetworkFirewallLoggingConfiguration < AwsResourceBase
  name 'aws_network_firewall_logging_configuration'
  desc 'Returns the logging configuration for the specified firewall.'

  example "
    describe aws_network_firewall_logging_configuration(firewall_name: 'FirewallName') do
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
      resp = @aws.network_firewall_client.describe_logging_configuration({ firewall_name: opts[:firewall_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def firewall_name
    return nil unless exists?
    @res[:firewall_name]
  end

  def resource_id
    @res? @res[:firewall_arn]: ''
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Firewall Name: #{@display_name}"
  end

  def logging_configuration_log_destination_configs_log_type
    logging_configuration.map(&:log_destination_configs).map(&:log_type)
  end

  def logging_configuration_log_destination_configs_log_destination_type
    logging_configuration.map(&:log_destination_configs).map(&:log_destination_type)
  end

  def logging_configuration_log_destination_configs_log_destination
    logging_configuration.map(&:log_destination_configs).map(&:log_destination)
  end
end
