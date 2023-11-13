require 'aws_backend'

class AwsVpcs < AwsResourceBase
  name 'aws_vpcs'
  desc 'Verifies settings for an AWS VPCs in bulk.'

  example "
    describe aws_vpcs do
      it { should exist }
    end
  "
  attr_reader :table

  # FilterTable setup
  FilterTable.create
             .register_column(:cidr_blocks, field: :cidr_block, style: :simple)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:states, field: :state, style: :simple)
             .register_column(:dhcp_options_ids, field: :dhcp_options_id)
             .register_column(:instance_tenancies, field: :instance_tenancy, style: :simple)
             .register_column(:is_default, field: :is_default, style: :simple)
             .register_column(:defaults, field: :defaults, style: :simple)
             .register_column(:tags, field: :tags)
             .register_column(:cidr_block_association_ids, field: :cidr_block_association_ids, style: :simple)
             .register_column(:associated_cidr_blocks, field: :associated_cidr_blocks, style: :simple)
             .register_column(:cidr_block_states, field: :cidr_block_states, style: :simple)
             .register_column(:ipv6_cidr_block_association_ids, field: :ipv6_cidr_block_association_ids, style: :simple)
             .register_column(:ipv6_cidr_blocks, field: :ipv6_cidr_blocks, style: :simple)
             .register_column(:ipv6_cidr_block_states, field: :ipv6_cidr_block_states, style: :simple)
             .register_column(:ipv6_network_border_groups, field: :ipv6_network_border_groups, style: :simple)
             .register_column(:ipv6_pools, field: :ipv6_pools, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  private

  def fetch_data
    vpc_rows = []
    paginate_request do |api_response|
      vpc_rows += api_response.vpcs.map do |vpc|
        flat_hash_for(vpc)
      end
    end
    vpc_rows
  end

  def paginate_request
    pagination_options = { max_results: 100 }
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_vpcs(pagination_options)
      end
      return [] if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_for(vpc)
    vpc.to_h.tap do |hash|
      hash[:defaults] =  vpc.is_default ? vpc.vpc_id : nil
      hash[:tags] = map_tags(vpc.tags)

      cidr_block_associations = vpc.cidr_block_association_set
      hash[:cidr_block_association_ids] = map_attributes_from(cidr_block_associations, 'association_id')
      hash[:associated_cidr_blocks] = map_attributes_from(cidr_block_associations, 'cidr_block')
      hash[:cidr_block_states] = map_attributes_from(cidr_block_associations, 'cidr_block_state&.state')

      ipv6_cidr_block_associations = vpc.ipv_6_cidr_block_association_set
      hash[:ipv6_cidr_block_association_ids] = map_attributes_from(ipv6_cidr_block_associations, 'association_id')
      hash[:ipv6_cidr_blocks] = map_attributes_from(ipv6_cidr_block_associations, 'ipv_6_cidr_block')
      hash[:ipv6_cidr_block_states] = map_attributes_from(ipv6_cidr_block_associations, 'ipv_6_cidr_block_state&.state')
      hash[:ipv6_network_border_groups] = map_attributes_from(ipv6_cidr_block_associations, 'network_border_group')
      hash[:ipv6_pools] = map_attributes_from(ipv6_cidr_block_associations, 'ipv_6_pool')
    end
  end

  def map_attributes_from(association, attribute)
    association.map { |assoc| assoc.instance_eval(attribute) }
  end
end
