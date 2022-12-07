require 'aws_backend'

class AwsNatGateways < AwsResourceBase
  name 'aws_nat_gateways'
  desc 'Verifies settings for a collection of AWS NAT gateways.'

  example "
    describe aws_nat_gateways do
      its('count') { should eq 3 }
    end

    describe aws_nat_gateways.where(name: 'my-gateway') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:names, field: :name)
             .register_column(:tags, field: :tags)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:subnet_ids, field: :subnet_id)
             .register_column(:states, field: :state)
             .register_column(:nat_gateways, field: :nat_gateway)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def to_s
    "NAT Gateway #{@display_name}"
  end

  def fetch_data
    ngw_rows = []
    query_params = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_nat_gateways(query_params)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.nat_gateways.each do |ngw|
        ngw_tags = map_tags(ngw.tags)
        ngw_rows += [{
          id: ngw.nat_gateway_id,
          tags: ngw_tags,
          name: ngw_tags['Name'],
          subnet_id: ngw.subnet_id,
          vpc_id: ngw.vpc_id,
          state: ngw.state,
        }]
      end
      break unless @api_response.next_token
      query_params[:next_token] = @api_response.next_token
    end
    ngw_rows
  end
end
