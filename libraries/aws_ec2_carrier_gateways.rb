require 'aws_backend'

class AWSEC2CarrierGateways < AwsResourceBase
  name 'aws_ec2_carrier_gateways'
  desc 'Describes multiple carrier gateways.'
  example <<-EXAMPLE
    describe aws_ec2_carrier_gateways do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:carrier_gateway_ids, field: :carrier_gateway_id)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:states, field: :state)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_carrier_gateways(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.carrier_gateways.each do |res|
        rows += [{ carrier_gateway_id: res.carrier_gateway_id,
                   vpc_id: res.vpc_id,
                   state: res.state,
                   owner_id: res.owner_id,
                   tags: res.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end
