require "aws_backend"

class AwsCloudwatchCompositeAlarms < AwsResourceBase
  name "aws_cloudwatch_composite_alarms"
  desc "Lists all composite alarms."

  example "
    describe aws_cloudwatch_composite_alarms do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:actions_enabled, field: :actions_enabled)
    .register_column(:alarm_actions, field: :alarm_actions)
    .register_column(:alarm_arns, field: :alarm_arn)
    .register_column(:alarm_configuration_updated_timestamp, field: :alarm_configuration_updated_timestamp)
    .register_column(:alarm_descriptions, field: :alarm_description)
    .register_column(:alarm_names, field: :alarm_name)
    .register_column(:alarm_rules, field: :alarm_rule)
    .register_column(:insufficient_data_actions, field: :insufficient_data_actions)
    .register_column(:ok_actions, field: :ok_actions)
    .register_column(:state_reasons, field: :state_reason)
    .register_column(:state_reason_data, field: :state_reason_data)
    .register_column(:state_updated_timestamp, field: :state_updated_timestamp)
    .register_column(:state_values, field: :state_value)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudwatch_client.describe_alarms(alarm_types: ["CompositeAlarm"]).map do |table|
        table.composite_alarms.map { |table_name| {
          actions_enabled: table_name.actions_enabled,
          alarm_actions: table_name.alarm_actions,
          alarm_arn: table_name.alarm_arn,
          alarm_configuration_updated_timestamp: table_name.alarm_configuration_updated_timestamp,
          alarm_description: table_name.alarm_description,
          alarm_name: table_name.alarm_name,
          alarm_rule: table_name.alarm_rule,
          insufficient_data_actions: table_name.insufficient_data_actions,
          ok_actions: table_name.ok_actions,
          state_reason: table_name.state_reason,
          state_reason_data: table_name.state_reason_data,
          state_updated_timestamp: table_name.state_updated_timestamp,
          state_value: table_name.state_value,
        }
        }
      end.flatten
    end
  end
end
