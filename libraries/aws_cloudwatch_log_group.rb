# frozen_string_literal: true

require 'aws_backend'

class AwsCloudWatchLogGroup < AwsResourceBase
  name 'aws_cloudwatch_log_group'
  desc 'Verifies settings for an AWS CloudWatch Log Group.'

  attr_reader :log_group_name, :limit, :retention_in_days, :metric_filter_count, :kms_key_id, :tags, :arn

  def initialize(opts = {})
    opts = { log_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:log_group_name])

    if !opts[:log_group_name].is_a?(String)
      raise ArgumentError, "#{@__resource_name__}: `log_group_name` #{opts[:log_group_name]} is invalid, must be a string."
    end

    @log_group_name = opts[:log_group_name]
    @limit = opts[:limit] ? opts[:limit].to_i : 1

    catch_aws_errors do
      resp = @aws.cloudwatchlogs_client.describe_log_groups({ log_group_name_prefix: @log_group_name, limit: @limit })
      @log_groups = resp.log_groups
    end

    return false if @log_groups.empty?

    raise "Found multiple CloudWatch Log Groups. The following matched: #{@log_groups.join(', ')}. Try to restrict your resource criteria." if @log_groups.count > 1

    @retention_in_days = @log_groups.first.retention_in_days
    @metric_filter_count = @log_groups.first.metric_filter_count
    @kms_key_id = @log_groups.first.kms_key_id
    @arn = @log_groups.first.arn

    catch_aws_errors do
      resp = @aws.cloudwatchlogs_client.list_tags_log_group({ log_group_name: @log_group_name })
      @tags = resp.tags
    end
  end

  def resource_id
    @arn
  end

  def exists?
    !@log_groups.empty?
  end

  def to_s
    "CloudWatch Log Group #{@log_group_name}"
  end
end
