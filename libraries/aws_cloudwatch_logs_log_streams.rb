# frozen_string_literal: true

require 'aws_backend'

class AWSCloudWatchLogsDestinations < AwsResourceBase
  name 'aws_cloudwatch_logs_log_streams'
  desc 'Lists all Public Keys.'

  example "
    describe aws_cloudwatch_logs_log_streams(log_group_name: 'Log_Group_Name' ) do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:log_stream_name, field: :log_stream_name)
             .register_column(:creation_time, field: :creation_time)
             .register_column(:first_event_timestamp, field: :first_event_timestamp)
             .register_column(:last_event_timestamp, field: :last_event_timestamp)
             .register_column(:last_ingestion_time, field: :last_ingestion_time)
             .register_column(:upload_sequence_token, field: :upload_sequence_token)
             .register_column(:arn, field: :arn)
             .register_column(:stored_bytes, field: :stored_bytes)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(log_group_name))
    raise ArgumentError, "#{@__resource_name__}: log_stream_name_prefix must be provided" unless opts[:log_group_name] && !opts[:log_group_name].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudwatchlogs_client.describe_log_streams.map do |table|
        table.log_streams.map { |table_name| {
          log_stream_name: table_name.log_stream_name,
          creation_time: table_name.creation_time,
          first_event_timestamp: table_name.first_event_timestamp,
          last_event_timestamp: table_name.last_event_timestamp,
          last_ingestion_time: table_name.last_ingestion_time,
          upload_sequence_token: table_name.upload_sequence_token,
          arn: table_name.arn,
          stored_bytes: table_name.stored_bytes,
        }
        }
      end.flatten
    end
  end
end
