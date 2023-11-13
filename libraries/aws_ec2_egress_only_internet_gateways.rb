require 'aws_backend'

class AWSEC2EgressOnlyInternetGateways < AwsResourceBase
  name 'aws_ec2_egress_only_internet_gateways'
  desc 'Describes one or more of your egress-only internet gateways.'

  example "
    describe aws_ec2_egress_only_internet_gateways do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:attachments, field: :attachments)
             .register_column(:egress_only_internet_gateway_ids, field: :egress_only_internet_gateway_id)
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
        @api_response = @aws.compute_client.describe_egress_only_internet_gateways(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.egress_only_internet_gateways.each do |res|
        rows += [{ attachments: res.attachments,
                   egress_only_internet_gateway_id: res.egress_only_internet_gateway_id,
                   tags: res.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end
