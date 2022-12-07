require 'aws_backend'

class AwsVPNGateways < AwsResourceBase
  name 'aws_vpn_gateways'
  desc 'Verifies settings for AWS VPN Gateways.'

  example "
    describe aws_vpn_gateways do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:availability_zones, field: :availability_zone, style: :simple)
             .register_column(:states, field: :state)
             .register_column(:types, field: :type)
             .register_column(:vpn_gateway_ids, field: :vpn_gateway_id)
             .register_column(:amazon_side_asns, field: :amazon_side_asn)
             .register_column(:tags, field: :tags)
             .register_column(:vpc_attachments, field: :vpc_attachments)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super
    validate_parameters
    @table = fetch
  end

  private

  def fetch
    vpn_gateways = query&.vpn_gateways
    return [] unless vpn_gateways

    vpn_gateways.map do |vpn_gateway|
      vpn_gateway_hashmap = vpn_gateway.to_h
      vpn_gateway_hashmap[:tags] = vpn_gateway.tags.empty? ? [] : map_tags(vpn_gateway.tags)
      vpn_gateway_hashmap[:vpc_attachments] = vpn_gateway.vpc_attachments.empty? ? [] : vpn_gateway.vpc_attachments.first.to_h
      vpn_gateway_hashmap
    end
  end

  def query
    catch_aws_errors do
      @aws.compute_client.describe_vpn_gateways
    end
  end
end
