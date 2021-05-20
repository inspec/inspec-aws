# frozen_string_literal: true

require 'aws_backend'

class AwsStatesStateMachines < AwsResourceBase
  name 'aws_states_state_machines'
  desc 'Verifies settings for a collection of AWS StepFunction State Machines'
  example "
    describe aws_states_state_machines do
      its('count') { should eq 3 }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns, field: :arn)
             .register_column(:names, field: :name)
             .register_column(:types, field: :type)
             .register_column(:tags, field: :tags)
             .register_column(:status, field: :status)
             .register_column(:log_levels, field: :log_level)
             .register_column(:log_execution_datas, field: :log_execution_data)
             .register_column(:log_execution_datas, field: :log_execution_data)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    state_machine_rows = []
    catch_aws_errors do
      @api_response = @aws.states_client.list_state_machines
    end
    @api_response.each do |resp|
      resp.state_machines.each do |state_machine|
        state_machine_rows += [{ name: state_machine.name,
                                arn: state_machine.state_machine_arn,
                                type: state_machine.type,
                          tags: fetch_tags(state_machine.state_machine_arn),
                          **fetch_state_machine(state_machine.state_machine_arn) }]
      end
    end
    state_machine_rows
  end

  def fetch_state_machine(arn)
    resp = @aws.states_client.describe_state_machine(state_machine_arn: arn)
    {
        status: resp.status,
        log_level: resp.logging_configuration.level,
        log_execution_data: resp.logging_configuration.include_execution_data,
        tracing_enabled: resp.tracing_configuration.enabled
    }
  end

  def fetch_tags(arn)
    begin
      tag_list = @aws.states_client.list_tags_for_resource(resource_arn: arn)
    rescue
      return {}
    end
    map_tags(tag_list.tags)
  end
end
