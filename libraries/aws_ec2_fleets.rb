require 'aws_backend'

class AWSEC2Fleets < AwsResourceBase
  name 'aws_ec2_fleets'
  desc 'Describes the specified EC2 Fleets or all of your EC2 Fleets.'

  example "
    describe aws_ec2_fleets do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:activity_statuses, field: :activity_status)
             .register_column(:create_times, field: :create_time)
             .register_column(:fleet_ids, field: :fleet_id)
             .register_column(:fleet_states, field: :fleet_state)
             .register_column(:client_tokens, field: :client_token)
             .register_column(:excess_capacity_termination_policies, field: :excess_capacity_termination_policy)
             .register_column(:fulfilled_capacities, field: :fulfilled_capacity)
             .register_column(:fulfilled_on_demand_capacities, field: :fulfilled_on_demand_capacity)
             .register_column(:launch_template_configs, field: :launch_template_configs)
             .register_column(:target_capacity_specifications, field: :target_capacity_specification)
             .register_column(:terminate_instances_with_expiration, field: :terminate_instances_with_expiration)
             .register_column(:types, field: :type)
             .register_column(:valid_from, field: :valid_from)
             .register_column(:valid_until, field: :valid_until)
             .register_column(:replace_unhealthy_instances, field: :replace_unhealthy_instances)
             .register_column(:spot_options, field: :spot_options)
             .register_column(:on_demand_options, field: :on_demand_options)
             .register_column(:tags, field: :tags)
             .register_column(:errors, field: :errors)
             .register_column(:instances, field: :instances)
             .register_column(:contexts, field: :context)
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
        @api_response = @aws.compute_client.describe_fleets(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.fleets.each do |res|
        rows += [{ activity_status: res.activity_status,
                   create_time: res.create_time,
                   fleet_id: res.fleet_id,
                   fleet_state: res.fleet_state,
                   client_token: res.client_token,
                   excess_capacity_termination_policy: res.excess_capacity_termination_policy,
                   fulfilled_capacity: res.fulfilled_capacity,
                   fulfilled_on_demand_capacity: res.fulfilled_on_demand_capacity,
                   launch_template_configs: res.launch_template_configs,
                   target_capacity_specification: res.target_capacity_specification,
                   terminate_instances_with_expiration: res.terminate_instances_with_expiration,
                   type: res.type,
                   valid_from: res.valid_from,
                   valid_until: res.valid_until,
                   replace_unhealthy_instances: res.replace_unhealthy_instances,
                   spot_options: res.spot_options,
                   on_demand_options: res.on_demand_options,
                   tags: res.tags,
                   errors: res.errors,
                   instances: res.instances,
                   context: res.context }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end
