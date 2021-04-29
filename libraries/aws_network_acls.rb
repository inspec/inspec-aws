# frozen_string_literal: true

require 'aws_backend'

class AwsNetworkACLs < AwsResourceBase
  name 'aws_network_acls'
  desc 'Verifies settings for a collection of AWS internet gateways.'

  example "
    describe aws_network_acls do
      its('count') { should eq 3 }
    end

    describe aws_network_acls.where(name: 'my-gateway') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:network_acl_ids, field: :network_acl_id)
             .register_column(:associations, field: :associations, style: :simple)
             .register_column(:entries, field: :entries, style: :simple)
             .register_column(:defaults, field: :defaults, style: :simple)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:tags, field: :tags)
             .register_column(:vpc_ids, field: :vpc_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    network_acls = []
    paginate_request do |api_response|
      network_acls += api_response.network_acls.map do |network_acl|
        flat_hash_from(network_acl)
      end
    end
    network_acls
  end

  private

  def paginate_request
    pagination_options = { max_results: 1000 }
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_network_acls(pagination_options)
      end
      return [] if api_response.blank?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_from(network_acl)
    network_acl_hash = network_acl.to_h
    network_acl_hash[:defaults] = network_acl_hash.delete(:is_default) ? network_acl.network_acl_id : nil
    network_acl_hash[:tags] = network_acl.tags.blank? ? nil : map_tags(network_acl.tags)
    network_acl_hash[:entries] = network_acl_hash[:entries].map { |entry| entry[:network_acl_id] = network_acl.network_acl_id; entry }
    network_acl_hash
  end
end
