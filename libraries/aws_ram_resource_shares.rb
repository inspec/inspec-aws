# frozen_string_literal: true

require 'aws_backend'

class AWSRAMResourceShares < AwsResourceBase
  name 'aws_ram_resource_shares'
  desc 'Describes the resource shares of the ram.'

  example "
    describe aws_ram_resource_shares(resource_owner: 'SELF') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                                        field: :arn)
             .register_column(:types,                                       field: :type)
             .register_column(:resource_share_arns,                         field: :resource_share_arn)
             .register_column(:resource_group_arns,                         field: :resource_group_arn)
             .register_column(:statuses,                                    field: :status)
             .register_column(:status_messages,                             field: :status_message)
             .register_column(:creation_times,                              field: :creation_time)
             .register_column(:last_updated_times,                          field: :last_updated_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(resource_owner))
    @query_params = {}
    @query_params[:resource_owner] = opts[:resource_owner]
    if opts.key?(:resource_owner)
      raise ArgumentError, "#{@__resource_name__}: resource_owner must be provided" unless opts[:resource_owner] && !opts[:resource_owner].empty?
      @query_params[:resource_owner] = opts[:resource_owner]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.ram_client.list_resources(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.resources.each do |res|
        rows += [{ arn: res.arn,
                   type: res.type,
                   resource_share_arn: res.resource_share_arn,
                   resource_group_arn: res.resource_group_arn,
                   status: res.status,
                   status_message: res.status_message,
                   creation_time: res.creation_time,
                   last_updated_time: res.last_updated_time }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end

  def fetch_data1
    catch_aws_errors do
      @resp = @aws.ram_client.list_resources(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.resources.map(&:to_h)
  end
end
