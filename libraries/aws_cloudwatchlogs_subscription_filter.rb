require "aws_backend"

class AWSCloudWatchLogsSubscriptionFilter < AwsResourceBase
  name "aws_cloudwatchlogs_subscription_filter"
  desc "Describes single subscription filter."
  example <<-EXAMPLE
    describe aws_cloudwatchlogs_subscription_filter(log_group_name: 'LOG_GROUP_NAME', filter_name_prefix: 'FILTER_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { filter_name_prefix: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[log_group_name filter_name_prefix])
    unless opts[:log_group_name] && !opts[:log_group_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: log_group_name must be provided"
    end
    unless opts[:filter_name_prefix] && !opts[:filter_name_prefix].empty?
      raise ArgumentError,
            "#{@__resource_name__}: filter_name_prefix must be provided"
    end
    @display_name = opts[:filter_name_prefix]
    catch_aws_errors do
      resp =
        @aws.cloudwatchlogs_client.describe_subscription_filters(
          {
            log_group_name: opts[:log_group_name],
            filter_name_prefix: opts[:filter_name_prefix]
          }
        )
      @filter = resp.subscription_filters[0].to_h
      @filter_name = @filter[:filter_name]
      @filter_log_group_name = @filter[:log_group_name]
      @filter_role_arn = @filter[:role_arn]
      create_resource_methods(@filter)
    end
  end

  def resource_id
    "#{@filter_name}_#{@filter_log_group_name}_#{@filter_role_arn}"
  end

  def filter_name_prefix
    return nil unless exists?
    @filter[:filter_name_prefix]
  end

  def exists?
    !@filter.nil? && !@filter.empty?
  end

  def to_s
    "Subscription Filter Name: #{@display_name}"
  end
end
