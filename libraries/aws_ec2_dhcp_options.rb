require "aws_backend"

class AwsEc2DHCPOptions< AwsResourceBase
  SERVER_TYPES = %w{domain-name-servers netbios-name-servers ntp-servers}.freeze
  name "aws_ec2_dhcp_options"
  desc "Verifies settings for AWS EC2 DHCP Options."

  example "
    describe aws_ec2_dhcp_options do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:dhcp_options_ids,      field: :dhcp_options_id)
    .register_column(:owner_ids,             field: :owner_id)
    .register_column(:tags,                  field: :tags)
    .register_column(:domain_names,          field: :domain_name)
    .register_column(:domain_name_servers,   field: :domain_name_servers, style: :simple)
    .register_column(:netbios_name_servers,  field: :netbios_name_servers, style: :simple)
    .register_column(:netbios_node_types,    field: :netbios_node_type)
    .register_column(:ntp_servers,           field: :ntp_servers, style: :simple)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    dhcp_options = []
    paginate_request do |api_response|
      dhcp_options += api_response.dhcp_options.map { |dhcp_option| flat_hash_from(dhcp_option) }
    end
    dhcp_options
  end

  private

  def paginate_request
    pagination_options = {}
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_dhcp_options(pagination_options)
      end
      return [] if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_from(dhcp_option)
    {}.tap do |hash|
      hash[:dhcp_options_id] = dhcp_option.dhcp_options_id
      hash[:owner_id] = dhcp_option.owner_id
      hash[:tags] = dhcp_option.tags.empty? ? [] : map_tags(dhcp_option.tags)
      dhcp_configs = dhcp_option.dhcp_configurations
      hash[:domain_name] = domain_name_for(dhcp_configs)
      hash[:netbios_node_type] = netbios_node_type_for(dhcp_configs)
      SERVER_TYPES.each do |server_type|
        hash[server_type.gsub("-", "_").to_sym] = servers_for(dhcp_configs, type: server_type)
      end
    end
  end

  def domain_name_for(dhcp_configurations)
    domain_name = find_config_for(dhcp_configurations, type: "domain-name")
    return NullResponse unless domain_name # this is not possible though!

    domain_name[:values].first[:value]
  end

  def servers_for(dhcp_configurations, type:)
    server_configuration = find_config_for(dhcp_configurations, type: type)
    return [] unless server_configuration

    server_configuration[:values].map { |config| config[:value] }
  end

  def netbios_node_type_for(dhcp_configurations)
    netbios_node_type = find_config_for(dhcp_configurations, type: "netbios-node-type")
    return NullResponse unless netbios_node_type

    netbios_node_type[:values].first[:value].to_i
  end

  def find_config_for(configurations, type:)
    configurations.find { |config| config[:key] == type }
  end
end
