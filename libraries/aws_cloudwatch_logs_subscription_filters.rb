# frozen_string_literal: true

require 'aws_backend'

class AWSCloudWatchLogsSubscriptionFilters < AwsResourceBase
  name 'aws_cloudwatch_logs_subscription_filters'
  desc 'Describes multiple subscription filter.'

  example "
   describe aws_cloudwatch_logs_subscription_filters(log_group_name: 'LOG_GROUP_NAME') do
     it { should exist }
   end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:filter_names, field: :filter_name)
             .register_column(:log_group_names, field: :log_group_name)
             .register_column(:filter_patterns, field: :filter_pattern)
             .register_column(:destination_arns, field: :destination_arn)
             .register_column(:role_arns, field: :role_arn)
             .register_column(:distributions, field: :distribution)
             .register_column(:creation_time, field: :creation_time)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudwatchlogs_client.describe_subscription_filters.map do |table|
        table.subscription_filters.map { |table_name| {
          filter_name: table_name.filter_name,
          log_group_name: table_name.log_group_name,
          filter_pattern: table_name.filter_pattern,
          destination_arn: table_name.destination_arn,
          role_arn: table_name.role_arn,
          distribution: table_name.distribution,
          creation_time: table_name.creation_time,
        }
        }
      end.flatten
    end
  end
end
