# frozen_string_literal: true

require 'aws_backend'

class AWSEC2VPNConnectionRoutePropagations < AwsResourceBase
  name 'aws_ec2_vpn_gateway_route_propagations'
  desc 'Describes one or more of your VPN connections route.'

  example "
    describe aws_ec2_vpn_gateway_route_propagations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:destination_cidr_blocks, field: :destination_cidr_block)
             .register_column(:sources, field: :source)
             .register_column(:states, field: :state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_vpn_connections(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.vpn_connections.each do |resp|
        next if resp.routes.nil?
        rows += [{ destination_cidr_block: resp.destination_cidr_block,
                   source: resp.source,
                   state: resp.state }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
