require 'aws_backend'

class AWSEC2VPNConnectionRoutes < AwsResourceBase
  name 'aws_ec2_vpn_connection_routes'
  desc 'Describes one or more of your VPN connections route.'

  example "
    describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPNConnectionID') do
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
    raise ArgumentError, "#{@__resource_name__}: vpn_connection_id must be provided" unless opts[:vpn_connection_id] && !opts[:vpn_connection_id].empty?
    @table = fetch_data
  end

  def fetch_data
    rows = []
    catch_aws_errors do
      @api_response = @aws.compute_client.describe_vpn_connections({ vpn_connection_ids: [opts[:vpn_connection_id]] })
    end
    return rows if !@api_response || @api_response.empty?
    @api_response.vpn_connections.each do |resp|
      next if resp.routes.nil?
      rows += [{ destination_cidr_block: resp.routes.map(&:destination_cidr_block),
                 source: resp.routes.map(&:source),
                 state: resp.routes.map(&:state) }]
    end
    rows
  end
end
