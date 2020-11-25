# frozen_string_literal: true

require 'aws_backend'

class AwsVpnConnections < AwsResourceBase
  name 'aws_vpn_connections'
  desc 'Verifies settings for an AWS VPN connections in bulk'

  example '
    describe aws_vpn_connections do
      it { should exist }
    end
  '
  attr_reader :table

  # FilterTable setup
  FilterTable.create
              .register_column(:vpn_connection_ids,  field: :vpn_connection_id)
              .register_column(:vpn_gateway_ids,     field: :vpn_gateway_id)
              .register_column(:tunnel_options,     field: :tunnel_options)
              .register_column(:states,              field: :state)
              .register_column(:types,               field: :type)
              .register_column(:tags,               field: :tags)
              .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    vpn_connection_rows = []
    catch_aws_errors do
      @api_response = @aws.compute_client.describe_vpn_connections.vpn_connections
    end
    return [] if !@api_response || @api_response.empty?
    @api_response.map do |vpn_connection|
      vpn_connection_rows+=[{ vpn_connection_id: vpn_connection.to_h[:vpn_connection_id],
        vpn_gateway_id: vpn_connection.to_h[:vpn_gateway_id],
        tunnel_options: vpn_connection.to_h[:options][:tunnel_options],
        state: vpn_connection.to_h[:state],
        type: vpn_connection.to_h[:type],
        tags: map_tags(vpn_connection.to_h[:tags]) }]
    end
    @table = vpn_connection_rows
  end
end
