require 'aws_backend'
class AwsEc2DHCPOption < AwsResourceBase
  SERVER_TYPES = %w{domain-name-servers netbios-name-servers ntp-servers}.freeze

  name 'aws_ec2_dhcp_option'
  desc 'Verifies settings for an AWS EC2 DHCP Option.'

  example "
    describe aws_ec2_dhcp_option('dotp-12345678') do
      it { should exist }
    end

    describe aws_ec2_dhcp_option(name: 'dotp-12345678') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { dhcp_options_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(dhcp_options_id name))
    validate_and_assign_from(opts)

    response = catch_aws_errors do
      @aws.compute_client.describe_dhcp_options(instance_arguments)
    end
    if !response&.dhcp_options || response.dhcp_options.empty?
      empty_response_warn
    else
      @dhcp_option = response.dhcp_options.first.to_h
      create_resource_methods(@dhcp_option)
    end
    define_server_types
  end

  def exists?
    !failed_resource?
  end

  def resource_id
    @dhcp_option ? @dhcp_option[:dhcp_options_id] : display_name
  end

  def to_s
    "EC2 DHCP Option Set: #{display_name}"
  end

  def netbios_node_type
    netbios_node_type = config_for('netbios-node-type')
    return NullResponse unless netbios_node_type

    netbios_node_type[:values].first[:value].to_i
  end

  def domain_name
    domain_name = config_for('domain-name')
    return NullResponse unless domain_name

    domain_name[:values].first[:value]
  end

  private

  attr_reader :dhcp_options_id, :name

  def define_server_types
    SERVER_TYPES.each do |server|
      method_name = server.gsub('-', '_')
      define_singleton_method(method_name) do
        server_configuration = config_for(server)
        return [] unless server_configuration

        server_configuration[:values].map { |config| config[:value] }
      end
    end
  end

  def config_for(config_key)
    return unless @dhcp_option

    @dhcp_option[:dhcp_configurations].find { |config| config[:key] == config_key }
  end

  def display_name
    dhcp_options_id || name
  end

  def instance_arguments
    return @instance_arguments if @instance_arguments

    @instance_arguments = if dhcp_options_id
                            { dhcp_options_ids: [dhcp_options_id] }
                          else
                            build_filters_from(name)
                          end
  end

  def build_filters_from(value)
    { filters: [{ name: 'tag:Name', values: [value] }] }
  end

  def validate_and_assign_from(opts)
    if opts[:dhcp_options_id] && !opts[:dhcp_options_id].empty?
      if !opts[:dhcp_options_id].is_a?(String) || opts[:dhcp_options_id] !~ /^dopt-[a-z0-9]+$/
        raise ArgumentError, "#{@__resource_name__}: `dhcp_options_id` must be a string in the format of 'dopt-' followed by alphanumeric characters."
      end
      @dhcp_options_id = opts[:dhcp_options_id]
    elsif opts[:name] && !opts[:name].empty? # Otherwise use name, if provided
      @name = opts[:name]
    else
      raise ArgumentError, "#{@__resource_name__}: either dhcp_options_id or name must be provided."
    end
  end
end
