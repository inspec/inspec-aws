require 'aws_backend'

class AwsVPCEndpointServices < AwsResourceBase
  name 'aws_vpc_endpoint_services'
  desc 'Verifies settings for a collection of AWS VPC End Point Services.'

  example "
    describe aws_vpc_endpoint_services do
      its('count') { should eq 3 }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:service_names, field: :service_name)
             .register_column(:service_ids, field: :service_id)
             .register_column(:service_types, field: :service_type)
             .register_column(:availability_zones, field: :availability_zones, style: :simple)
             .register_column(:owners, field: :owner)
             .register_column(:base_endpoint_dns_names, field: :base_endpoint_dns_names, style: :simple)
             .register_column(:private_dns_names, field: :private_dns_name)
             .register_column(:vpc_endpoint_policy_supported, field: :vpc_endpoint_policy_supported)
             .register_column(:acceptance_required, field: :acceptance_required)
             .register_column(:manages_vpc_endpoints, field: :manages_vpc_endpoints)
             .register_column(:tags, field: :tags)
             .register_column(:private_dns_name_verification_states, field: :private_dns_name_verification_state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  private

  def fetch_data
    service_details = []
    paginate_request do |api_response|
      service_details += api_response.service_details.map do |service_detail|
        flat_hash_from(service_detail)
      end
    end
    service_details
  end

  def paginate_request
    pagination_options = { max_results: 1000 }
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_vpc_endpoint_services(pagination_options)
      end
      return if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_from(service_detail)
    service_detail_hash = service_detail.to_h
    service_detail_hash[:service_type] = service_detail.service_type.first.service_type
    service_detail_hash[:tags] = map_tags(service_detail.tags)
    service_detail_hash.delete(:private_dns_names)
    service_detail_hash
  end
end
