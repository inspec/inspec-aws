# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationCloudResources < AwsResourceBase
  name 'aws_cloudformation_custom_resources'
  desc 'Returns descriptions of all resources of the specified stack.'

  example "
    describe aws_cloudformation_custom_resources(stack_name: 'StackName') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:logical_resource_ids, field: :logical_resource_id)
             .register_column(:physical_resource_ids, field: :physical_resource_id)
             .register_column(:resource_types, field: :resource_type)
             .register_column(:last_updated_timestamps, field: :last_updated_timestamp)
             .register_column(:resource_statuses, field: :resource_status)
             .register_column(:resource_status_reasons, field: :resource_status_reason)
             .register_column(:drift_informations, field: :drift_information)
             .register_column(:module_infos, field: :module_info)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(stack_name))
    @query_params = {}
    if opts.key?(:stack_name)
      raise ArgumentError, "#{@__resource_name__}: stack_name must be provided" unless opts[:stack_name] && !opts[:stack_name].empty?
      @query_params[:stack_name] = opts[:stack_name]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.cloudformation_client.list_stack_resources(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.stack_resource_summaries.each do |resp|
        rows += [{ logical_resource_id: resp.logical_resource_id,
                   physical_resource_id: resp.physical_resource_id,
                   resource_type: resp.resource_type,
                   last_updated_timestamp: resp.last_updated_timestamp,
                   resource_status: resp.resource_status,
                   resource_status_reason: resp.resource_status_reason,
                   drift_information: resp.drift_information,
                   module_info: resp.module_info }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
