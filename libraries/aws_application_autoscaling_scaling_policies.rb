require 'aws_backend'

class AWSApplicationAutoScalingScalingPolicies < AwsResourceBase
  name 'aws_application_autoscaling_scaling_policies'
  desc 'Describes the Application AutoScaling scaling policies for the specified service namespace.'

  example "
    describe aws_application_autoscaling_scaling_policies(service_namespace: 'ec2') do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:policy_arns,                                                 field: :policy_arn)
             .register_column(:policy_names,                                                field: :policy_name)
             .register_column(:service_namespaces,                                          field: :service_namespace)
             .register_column(:resource_ids,                                                field: :resource_id)
             .register_column(:scalable_dimensions,                                         field: :scalable_dimension)
             .register_column(:policy_types,                                                field: :policy_type)
             .register_column(:step_scaling_policy_configurations,                          field: :step_scaling_policy_configuration)
             .register_column(:target_tracking_scaling_policy_configurations,               field: :target_tracking_scaling_policy_configuration)
             .register_column(:alarms,                                                      field: :alarms)
             .register_column(:creation_times,                                              field: :creation_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(service_namespace))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
    @query_params[:service_namespace] = opts[:service_namespace]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.applicationautoscaling_client.describe_scaling_policies(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.scaling_policies.each do |res|
        rows += [{
          policy_arn: res.policy_arn,
          policy_name: res.policy_name,
          service_namespace: res.service_namespace,
          resource_id: res.resource_id,
          scalable_dimension: res.scalable_dimension,
          policy_type: res.policy_type,
          step_scaling_policy_configuration: res.step_scaling_policy_configuration,
          target_tracking_scaling_policy_configuration: res.target_tracking_scaling_policy_configuration,
          alarms: res.alarms,
          creation_time: res.creation_time,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
