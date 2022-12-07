require 'aws_backend'

class AWSTransitGatewayMulticastGroupMembers < AwsResourceBase
  name 'aws_transit_gateway_multicast_group_members'
  desc 'Searches one or more transit gateway multicast groups and returns the group membership information.'

  example "
    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: 'tgw-mcast-domain-1234567890') do
      it { should exist }
    end

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: 'tgw-mcast-domain-1234567890') do
      its ('group_ip_addresses') { should include '224.0.0.1' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:group_ip_addresses,                    field: :group_ip_address)
             .register_column(:transit_gateway_attachment_ids,        field: :transit_gateway_attachment_id)
             .register_column(:subnet_ids,                            field: :subnet_id)
             .register_column(:resource_ids,                          field: :resource_id)
             .register_column(:resource_types,                        field: :resource_type)
             .register_column(:resource_owner_ids,                    field: :resource_owner_id)
             .register_column(:network_interface_ids,                 field: :network_interface_id)
             .register_column(:group_members,                         field: :group_member)
             .register_column(:group_sources,                         field: :group_source)
             .register_column(:member_types,                          field: :member_type)
             .register_column(:source_types,                          field: :source_type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(transit_gateway_multicast_domain_id))
    @query_params = {}
    @query_params[:transit_gateway_multicast_domain_id] = opts[:transit_gateway_multicast_domain_id]
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_multicast_domain_id must be provided" unless opts[:transit_gateway_multicast_domain_id] && !opts[:transit_gateway_multicast_domain_id].empty?
    @query_params[:transit_gateway_multicast_domain_id] = opts[:transit_gateway_multicast_domain_id]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.search_transit_gateway_multicast_groups(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.multicast_groups.each do |resp|
        rows += [{ group_ip_address: resp.group_ip_address,
                   transit_gateway_attachment_id: resp.transit_gateway_attachment_id,
                   subnet_id: resp.subnet_id,
                   resource_id: resp.resource_id,
                   resource_type: resp.resource_type,
                   resource_owner_id: resp.resource_owner_id,
                   network_interface_id: resp.network_interface_id,
                   group_member: resp.group_member,
                   group_source: resp.group_source,
                   member_type: resp.member_type,
                   source_type: resp.source_type }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
