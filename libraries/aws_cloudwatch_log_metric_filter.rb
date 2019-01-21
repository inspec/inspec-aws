# frozen_string_literal: true

require 'aws_backend'

class AwsCloudwatchLogMetricFilter < AwsResourceBase
  name 'aws_cloudwatch_log_metric_filter'
  desc 'Verifies individual Cloudwatch Log Metric Filters'

  example "
  # Look for a LMF by its filter name and log group name.  This combination
  # will always either find at most one LMF - no duplicates.
  describe aws_cloudwatch_log_metric_filter(
    filter_name: 'my-filter',
    log_group_name: 'my-log-group'
  ) do
    it { should exist }
  end

  # Search for an LMF by pattern and log group.
  # This could result in an error if the results are not unique.
  describe aws_cloudwatch_log_metric_filter(
    log_group_name:  'my-log-group',
    pattern: 'my-filter'
  ) do
    it { should exist }
  end
  "
  attr_reader :filter_name, :log_group_name, :metric_name, :metric_namespace, :pattern, :exists
  alias exists? exists

  def initialize(opts = {})
    # Call the parent class constructor
    raise ArgumentError, 'aws_cloudwatch_log_metric_filter - filter_name, patterbn or log_group arguments must be provided' if opts.is_a?(String)
    super(opts)
    validate_parameters(%i(filter_name log_group_name pattern))
    @search_criteria = {}
    @search_criteria[:filter_name_prefix] = opts[:filter_name] if opts[:filter_name]
    @search_criteria[:log_group_name] = opts[:log_group_name] if opts[:log_group_name]
    raise ArgumentError, 'aws_cloudwatch_log_metric_filter - filter_name, pattern or log_group_name arguments must be provided' if @search_criteria.empty? and !opts[:pattern]
    catch_aws_errors do
      begin
        @resp = @aws.cloudwatchlogs_client.describe_metric_filters(@search_criteria)
        @metric_filters = @resp.metric_filters
      rescue Aws::CloudWatchLogs::Errors::ResourceNotFoundException
        @exists = false
        return
      end
    end
    @metric_filters.select! { |lmf| lmf.filter_pattern == opts[:pattern] } if opts[:pattern]
    return false && @exists = false if @metric_filters.nil?
    return false && @exists = false if @metric_filters.empty?
    raise 'More than one result was returned, but aws_cloudwatch_log_metric_filter can only handle a single AWS resource.  Consider passing more resource parameters to narrow down the search.' if @metric_filters.count > 1
    @exists = true
    @filter_name = @metric_filters.first.filter_name
    @log_group_name = @metric_filters.first.log_group_name
    @pattern = @metric_filters.first.filter_pattern
    # AWS SDK returns an array of metric transformations
    # but only allows one (mandatory) entry, let's flatten that
    @metric_name = @metric_filters.first.metric_transformations.first.metric_name
    @metric_namespace = @metric_filters.first.metric_transformations.first.metric_namespace
  end

  def to_s
    "AWS Cloudwatch Log Metric Filter #{@metric_name}"
  end
end
