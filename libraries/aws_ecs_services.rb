# frozen_string_literal: true

require 'aws_backend'

class AWSECSServices < AwsResourceBase
  name 'aws_ecs_services'
  desc 'Lists the services that are running in a specified cluster.'

  example "
    describe aws_ecs_services(cluster: 'cluster_name') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:service_arns, field: :service_arns)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(cluster))
    @query_params = {}
    @query_params[:cluster] = opts[:cluster]
    if opts.key?(:server_id)
      raise ArgumentError, "#{@__resource_name__}: cluster must be provided" unless opts[:cluster] && !opts[:cluster].empty?
      @query_params[:cluster] = opts[:cluster]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.ecs_client.list_services(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.map(&:to_h)
  end
end
