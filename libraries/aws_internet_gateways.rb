require "aws_backend"

class AwsInternetGateways < AwsResourceBase
  name "aws_internet_gateways"
  desc "Verifies settings for a collection of AWS internet gateways."

  example "
    describe aws_internet_gateways do
      its('count') { should eq 3 }
    end

    describe aws_internet_gateways.where(name: 'my-gateway') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:ids, field: :id)
    .register_column(:names, field: :name)
    .register_column(:tags, field: :tags)
    .register_column(:vpc_ids, field: :vpc_id)
    .register_column(:owner_ids, field: :owner_id)
    .register_column(:attachment_states, field: :attachment_state)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    igw_rows = []
    query_params = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_internet_gateways(query_params)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.internet_gateways.each do |igw|
        igw_rows += [{
          id: igw.internet_gateway_id,
          name: igw[:tags].select { |tag| tag[:key] == "Name" }.first&.dig(:value),
          tags: igw.tags,
          owner_id: igw.owner_id,
          vpc_id: igw.attachments.empty? ? nil : igw.attachments.first[:vpc_id],
          attachment_state: igw.attachments.empty? ? "detached" : "attached",
        }]
      end
      break unless @api_response.next_token
      query_params[:next_token] = @api_response.next_token
    end
    igw_rows
  end
end
