# frozen_string_literal: true

require 'aws_backend'

class AWSApplicationAutoScalingScalableTargets < AwsResourceBase
  name 'aws_application_autoscaling_scalable_targets'
  desc 'Gets information about the scalable targets in the specified namespace.'

  example `
    describe aws_application_autoscaling_scalable_targets(service_namespace: "service_namespace") do
      it { should exist }
    end
  `

  attr_reader :table

  FilterTable.create
             .register_column(:service_namespaces,                                field: :service_namespace)
             .register_column(:resource_ids,                                      field: :resource_id)
             .register_column(:scalable_dimensions,                               field: :scalable_dimension)
             .register_column(:min_capacities,                                    field: :min_capacity)
             .register_column(:max_capacities,                                    field: :max_capacity)
             .register_column(:geo_locations,                                     field: :geo_location)
             .register_column(:role_arns,                                         field: :role_arn)
             .register_column(:creation_times,                                    field: :creation_time)
             .register_column(:suspended_states,                                  field: :suspended_state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(service_namespace))
    @query_params = {}
    @query_params[:service_namespace] = opts[:service_namespace]
    if opts.key?(:service_namespace)
      raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
      @query_params[:service_namespace] = opts[:service_namespace]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.applicationautoscaling_client.describe_scalable_targets(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.scalable_targets.map(&:to_h)
  end
end
