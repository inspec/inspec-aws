require "aws_backend"

class AwsDhcpOptions < AwsResourceBase
  name "aws_dhcp_options"
  desc "Verifies settings for an AWS DHCP Options."
  example <<-EXAMPLE
    describe aws_dhcp_options(dhcp_options_id: 'DHCP_OPTIONS_ID) do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    Inspec::Log.warn deprecation_notice
    opts = { dhcp_options_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:dhcp_options_id])

    if !opts[:dhcp_options_id].is_a?(String) || opts[:dhcp_options_id] !~ /^dopt\-([0-9a-f]{8})|(^dopt\-[0-9a-f]{17})$/
      raise ArgumentError, "#{@__resource_name__}: `dhcp_options_id` #{opts[:dhcp_options_id]} is invalid, must be a string in the format of 'dopt-' followed by 8 or 17 hexadecimal characters."
    end

    @display_name = opts[:dhcp_options_id]
    filter = { name: "dhcp-options-id", values: [opts[:dhcp_options_id]] }

    catch_aws_errors do
      resp = @aws.compute_client.describe_dhcp_options({ filters: [filter] })
      @dhcp_options = resp.dhcp_options[0].to_h
      create_resource_methods(@dhcp_options)
    end
  end

  def exists?
    !@dhcp_options.empty?
  end

  def domain_name_servers
    _dhcp_config("domain-name-servers")
  end

  def ntp_servers
    _dhcp_config("ntp-servers")
  end

  def resource_id
    @dhcp_options ? @dhcp_options[:dhcp_options_id]: @display_name
  end

  def to_s
    opts.key?(:aws_region) ? "DHCP Options #{@display_name} in #{opts[:aws_region]}" : "DHCP Options #{@display_name}"
  end

  private

  def _dhcp_config(key)
    config = @dhcp_options[:dhcp_configurations].select { |c| c[:key] == key }
    return [] if config.empty?
    config[0][:values].map { |v| v[:value] }
  end

  def deprecation_notice
    "DEPRECATION: `aws_dhcp_options` will be deprecated soon and it is advised to switch to the new resource `aws_ec2_dhcp_option`. "\
    "Please see the documentation for the additional features available."
  end
end
