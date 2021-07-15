# frozen_string_literal: true

require 'aws_backend'

class AWSLogsMetricFilter < AwsResourceBase
  name 'aws_logs_metric_filter'
  desc 'Lists the specified metric filters.'

  example "
    describe aws_logs_metric_filter(filter_name: 'FilterName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { filter_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:filter_name])
    raise ArgumentError, "#{@__resource_name__}: filter_name must be provided" unless opts[:filter_name] && !opts[:filter_name].empty?
    @display_name = opts[:filter_name]
    catch_aws_errors do
      resp = @aws.cloudwatchlogs_client.describe_metric_filters({ filter_name_prefix: opts[:filter_name] })
      @metric_filters = resp.metric_filters[0].to_h
      create_resource_methods(@metric_filters)
    end
  end

  def filter_name
    return nil unless exists?
    @metric_filters[:filter_name_prefix]
  end

  def exists?
    !@metric_filters.nil? && !@metric_filters.empty?
  end

  def to_s
    "Filter Name: #{@display_name}"
  end
end
