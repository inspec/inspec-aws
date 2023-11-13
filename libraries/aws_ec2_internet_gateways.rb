require 'aws_backend'

class AWSEC2InternetGateways < AwsResourceBase
  name 'aws_ec2_internet_gateways'
  desc 'List all the internet gateways.'

  example "
    describe aws_ec2_internet_gateways do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:attachments, field: :attachments)
             .register_column(:attachments_states, field: :attachments_states, style: :simple)
             .register_column(:attachments_vpc_ids, field: :attachments_vpc_ids)
             .register_column(:internet_gateway_ids, field: :internet_gateway_id)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_internet_gateways(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.internet_gateways.each do |resp|
        rows += [{ attachments: resp.attachments,
                   attachments_states: resp.attachments.map(&:state),
                   attachments_vpc_ids: resp.attachments.map(&:vpc_id),
                   internet_gateway_id: resp.internet_gateway_id,
                   owner_id: resp.owner_id,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
