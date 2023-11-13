require 'aws_backend'

class AWSNetworkManagerGlobalNetworks < AwsResourceBase
  name 'aws_network_manager_global_networks'
  desc 'List all the global networks.'

  example "
    describe aws_network_manager_global_networks do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:global_network_ids, field: :global_network_id)
             .register_column(:global_network_arns, field: :global_network_arn)
             .register_column(:descriptions, field: :description)
             .register_column(:created_at, field: :created_at)
             .register_column(:states, field: :state)
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
        @api_response = @aws.network_manager_client.describe_global_networks(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.global_networks.each do |resp|
        rows += [{ global_network_id: resp.global_network_id,
                   global_network_arn: resp.global_network_arn,
                   description: resp.description,
                   created_at: resp.created_at,
                   state: resp.state,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
