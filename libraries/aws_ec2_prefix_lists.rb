require "aws_backend"

class AWSEC2PrefixLists < AwsResourceBase
  name "aws_ec2_prefix_lists"
  desc "List all the prefix list."

  example "
    describe aws_ec2_prefix_lists do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:prefix_list_ids, field: :prefix_list_id)
    .register_column(:address_families, field: :address_family)
    .register_column(:states, field: :state)
    .register_column(:state_messages, field: :state_message)
    .register_column(:prefix_list_arns, field: :prefix_list_arn)
    .register_column(:prefix_list_names, field: :prefix_list_name)
    .register_column(:max_entries, field: :max_entries)
    .register_column(:versions, field: :version)
    .register_column(:tags, field: :tags)
    .register_column(:owner_ids, field: :owner_id)
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
        @api_response = @aws.compute_client.describe_managed_prefix_lists(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.prefix_lists.each do |resp|
        rows += [{ prefix_list_id: resp.prefix_list_id,
                   address_family: resp.address_family,
                   state: resp.state,
                   state_message: resp.state_message,
                   prefix_list_arn: resp.prefix_list_arn,
                   prefix_list_name: resp.prefix_list_name,
                   max_entries: resp.max_entries,
                   version: resp.version,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
