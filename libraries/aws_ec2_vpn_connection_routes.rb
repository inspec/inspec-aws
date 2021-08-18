# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VPNConnectionRoutes < AwsResourceBase
  name 'aws_ec2_vpn_connection_routes'
  desc 'Specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway.'

  example "
    describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'vpn-1234567890') do
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
    validate_parameters(required: [:vpn_connection_id])
    @vpn_arguments = {}
    raise ArgumentError, "#{@__resource_name__}: vpn_connection_id  must be in the format 'vpn- followed by 8 or 17 hexadecimal characters." if opts[:vpn_connection_id] !~ /^vpn\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
    @display_name = opts[:vpn_connection_id]
    @vpn_arguments = { vpn_connection_ids: [opts[:vpn_connection_id]] }
    @table = fetch_data
  end

  def fetch_data
    vpn_rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_vpn_connections(@vpn_arguments)
      end
      return vpn_rows if !@api_response || @api_response.empty?
      @api_response.vpn_connections[0].routes.map do |route|
        vpn_rows += [{ destination_cidr_block: route.destination_cidr_block,
                       source: route.source,
                       state: route.state }]
      end
      break unless @api_response.next_token
    end
    @table = vpn_rows
  end
end
