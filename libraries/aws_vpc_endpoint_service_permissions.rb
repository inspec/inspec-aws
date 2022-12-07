require 'aws_backend'

class AwsVPCEndpointServicePermissions < AwsResourceBase
  name 'aws_vpc_endpoint_service_permissions'
  desc 'Describes the principals (service consumers) that are permitted to discover your VPC endpoint service.'
  example "
    describe aws_vpc_endpoint_service_permissions(service_id: 'vpce-svc-04deb776dc2b8e67f') do
      it { should exist }
    end
  "

  attr_reader :table, :params

  FilterTable.create
             .register_column(:principal_types, field: :principal_type, style: :simple)
             .register_column(:principals, field: :principal)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts)
    super
    validate_parameters(required: %i(service_id))
    @params = opts.slice(:service_id)
    @table = fetch_data
  end

  private

  def fetch_data
    endpoint_service_permissions = []
    paginate_request(params) do |api_response|
      endpoint_service_permissions += api_response.allowed_principals.map(&:to_h)
    end
    endpoint_service_permissions
  end

  def paginate_request(params)
    pagination_options = { max_results: 1000 }.merge(params)
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_vpc_endpoint_service_permissions(pagination_options)
      end
      return if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token

      pagination_options[:next_token] = api_response.next_token
    end
  end
end
