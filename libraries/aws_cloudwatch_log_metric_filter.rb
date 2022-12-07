require 'aws_backend'

class AwsCloudwatchLogMetricFilter < AwsResourceBase
  name 'aws_cloudwatch_log_metric_filter'
  desc 'Verifies individual Cloudwatch Log Metric Filters.'

  example "
  # Look for a Log Metric Filter. Results may be narrowed by a combination of filter name, log group name, or pattern.
  # If more than one Filter is returned, an error will be raised.
  describe aws_cloudwatch_log_metric_filter(filter_name: 'my-filter', log_group_name: 'my-log-group') do
    it { should exist }
  end
  "

  attr_reader :filter_name, :log_group_name, :metric_name, :metric_namespace, :pattern

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(filter_name log_group_name pattern))

    search_criteria = {}
    search_criteria[:filter_name_prefix] = opts[:filter_name] if opts[:filter_name]
    search_criteria[:log_group_name] = opts[:log_group_name] if opts[:log_group_name]

    catch_aws_errors do
      begin
        resp = @aws.cloudwatchlogs_client.describe_metric_filters(search_criteria)
        @metric_filters = resp.metric_filters
      rescue Aws::CloudWatchLogs::Errors::ResourceNotFoundException
        return
      end
    end

    # Narrow results if a pattern has been given.
    @metric_filters.select! { |lmf| lmf.filter_pattern == opts[:pattern] } if opts[:pattern]

    return false if @metric_filters.empty?

    if @metric_filters.count > 1
      raise 'More than one result was returned. Consider passing more parameters or a more specific pattern to narrow down results.'
    end

    @filter_name    = @metric_filters.first.filter_name
    @pattern        = @metric_filters.first.filter_pattern
    @log_group_name = @metric_filters.first.log_group_name

    @metric_name      = @metric_filters.first.metric_transformations.first.metric_name
    @metric_namespace = @metric_filters.first.metric_transformations.first.metric_namespace
  end

  def exists?
    !@metric_name.nil?
  end

  def resource_id
    "#{@filter_name}_#{@log_group_name}"
  end

  def to_s
    "AWS Cloudwatch Log Metric Filter #{@metric_name}"
  end
end
