require "aws_backend"

class AWSCloudWatchLogsLogStream < AwsResourceBase
  name "aws_cloudwatchlogs_log_stream"
  desc "Describes one or more of your logs Stream."
  example <<-EXAMPLE
    describe aws_cloudwatch_logs_log_stream(log_stream_name_prefix: 'LOG_STREAM_NAME', log_group_name: 'LOG_GROUP_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { log_stream_name_prefix: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(log_stream_name_prefix log_group_name))
    raise ArgumentError, "#{@__resource_name__}: log_stream_name_prefix must be provided." unless opts[:log_stream_name_prefix] && !opts[:log_stream_name_prefix].empty?
    raise ArgumentError, "#{@__resource_name__}: log_group_name must be provided." unless opts[:log_group_name] && !opts[:log_group_name].empty?
    @display_name = opts[:log_stream_name_prefix]
    catch_aws_errors do
      resp = @aws.cloudwatchlogs_client.describe_log_streams({ log_stream_name_prefix: opts[:log_stream_name_prefix], log_group_name: opts[:log_group_name] })
      @log_streams = resp.log_streams[0].to_h
      @log_stream_name = @log_streams[:log_stream_name]
      @log_stream_arn = @log_streams[:arn]
      create_resource_methods(@log_streams)
    end
  end

  def resource_id
    "#{@log_stream_name}_#{@log_stream_arn}"
  end

  def log_stream_name_prefix
    return unless exists?
    @log_streams[:log_stream_name_prefix]
  end

  def exists?
    !@log_streams.nil? && !@log_streams.empty?
  end

  def to_s
    "Destination Name: #{@display_name}"
  end
end
