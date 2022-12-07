require 'aws_backend'

class AwsRouteTables < AwsResourceBase
  name 'aws_route_tables'
  desc 'Verifies settings for an AWS Route Tables in bulk.'

  example "
    describe aws_route_tables do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:route_table_ids,                           field: :route_table_id)
             .register_column(:vpc_ids,                                   field: :vpc_id)
             .register_column(:destination_cidr_blocks,                   field: :destination_cidr_block, style: :simple)
             .register_column(:destination_ipv_6_cidr_blocks,             field: :destination_ipv_6_cidr_block, style: :simple)
             .register_column(:destination_prefix_list_ids,               field: :destination_prefix_list_id, style: :simple)
             .register_column(:egress_only_internet_gateway_ids,          field: :egress_only_internet_gateway_id, style: :simple)
             .register_column(:gateway_ids,                               field: :gateway_id, style: :simple)
             .register_column(:instance_ids,                              field: :instance_id, style: :simple)
             .register_column(:instance_owner_ids,                        field: :instance_owner_id, style: :simple)
             .register_column(:nat_gateway_ids,                           field: :nat_gateway_id, style: :simple)
             .register_column(:transit_gateway_ids,                       field: :transit_gateway_id, style: :simple)
             .register_column(:local_gateway_ids,                         field: :local_gateway_id, style: :simple)
             .register_column(:carrier_gateway_ids,                       field: :carrier_gateway_id, style: :simple)
             .register_column(:network_interface_ids,                     field: :network_interface_id, style: :simple)
             .register_column(:origins,                                   field: :origin, style: :simple)
             .register_column(:states,                                    field: :state, style: :simple)
             .register_column(:vpc_peering_connection_ids,                field: :vpc_peering_connection_id, style: :simple)
             .register_column(:route_table_association_ids,               field: :route_table_association_ids, style: :simple)
             .register_column(:association_subnet_ids,                    field: :association_subnet_ids, style: :simple)
             .register_column(:associated_subnet_ids,                     field: :associated_subnet_ids, style: :simple)
             .register_column(:association_gateway_ids,                   field: :association_gateway_ids, style: :simple)
             .register_column(:associated_gateway_ids,                    field: :associated_gateway_ids, style: :simple)
             .register_column(:association_states,                        field: :association_states, style: :simple)
             .register_column(:main,                                      field: :main, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    route_table_rows = []
    paginate_request do |api_response|
      route_table_rows += api_response.route_tables.map do |route_table|
        flat_hash_from(route_table)
      end
    end
    route_table_rows
  end

  private

  def paginate_request
    pagination_options = { max_results: 100 }
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_route_tables(pagination_options)
      end
      return if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_from(route_table)
    routes = route_table.routes
    associations = route_table.associations
    associates = associations.select { |association| association.association_state.state == 'associated' }
    {
      vpc_id: route_table.vpc_id,
      route_table_id: route_table.route_table_id,
      destination_cidr_block: map(routes, 'destination_cidr_block'),
      destination_ipv_6_cidr_block: map(routes, 'destination_ipv_6_cidr_block'),
      destination_prefix_list_id: map(routes, 'destination_prefix_list_id'),
      egress_only_internet_gateway_id: map(routes, 'egress_only_internet_gateway_id'),
      gateway_id: map(routes, 'gateway_id'),
      instance_id: map(routes, 'instance_id'),
      instance_owner_id: map(routes, 'instance_owner_id'),
      nat_gateway_id: map(routes, 'nat_gateway_id'),
      transit_gateway_id: map(routes, 'transit_gateway_id'),
      local_gateway_id: map(routes, 'local_gateway_id'),
      carrier_gateway_id: map(routes, 'carrier_gateway_id'),
      network_interface_id: map(routes, 'network_interface_id'),
      origin: map(routes, 'origin'),
      state: map(routes, 'state'),
      vpc_peering_connection_id: map(routes, 'vpc_peering_connection_id'),
      main: associations.any?(&:main),
      route_table_association_ids: map(associations, 'route_table_association_id'),
      association_subnet_ids: map(associations, 'subnet_id'),
      associated_subnet_ids: map(associates, 'subnet_id'),
      association_gateway_ids: map(associations, 'gateway_id'),
      associated_gateway_ids: map(associates, 'gateway_id'),
      association_states: map(associations, 'association_state.state'),
    }
  end

  def map(collection, attr)
    collection.map { |obj| obj.instance_eval(attr) }
  end
end
