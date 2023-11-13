require 'aws_backend'

class AwsVpces < AwsResourceBase
  name 'aws_vpc_endpoints'
  desc 'Verifies settings for an AWS VPC Endpoints in bulk.'

  example "
    describe aws_vpc_endpoints do
      it { should exist }
    end
  "
  attr_reader :table

  # FilterTable setup
  FilterTable.create
             .register_column(:vpc_endpoint_ids,     field: :vpc_endpoint_id)
             .register_column(:vpc_endpoint_types,   field: :vpc_endpoint_type)
             .register_column(:vpc_ids,              field: :vpc_id)
             .register_column(:service_names,        field: :service_name)
             .register_column(:states,               field: :state)
             .register_column(:route_table_ids,      field: :route_table_ids)
             .register_column(:subnet_ids,           field: :subnet_ids)
             .register_column(:private_dns_enabled,  field: :private_dns_enabled)
             .register_column(:tags,                 field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    vpce_rows = []
    catch_aws_errors do
      @vpces = @aws.compute_client.describe_vpc_endpoints
    end
    return vpce_rows if !@vpces || @vpces.empty?
    @vpces.vpc_endpoints.each do |vpce|
      vpce_rows+=[{ vpc_endpoint_id: vpce[:vpc_endpoint_id],
                    vpc_endpoint_type: vpce[:vpc_endpoint_type],
                    vpc_id: vpce[:vpc_id],
                    service_name: vpce[:service_name],
                    state: vpce[:state],
                    route_table_ids: vpce[:route_table_ids],
                    subnet_ids: vpce[:subnet_ids],
                    private_dns_enabled: vpce[:private_dns_enabled],
                    tags: map_tags(vpce[:tags]) }]
    end
    @table = vpce_rows
  end
end
