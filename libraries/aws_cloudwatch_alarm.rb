# frozen_string_literal: true

require 'aws_backend'

class AwsCloudwatchAlarm < AwsResourceBase
  name 'aws_cloudwatch_alarm'
  desc 'Verifies settings for an AWS CloudWatch Alarm'

  example "
  # Look for a specific alarm
  aws_cloudwatch_alarm(metric_name: 'my-metric-name', metric_namespace: 'my-metric-namespace') do
    it { should exist }
  end
  "
  attr_reader :alarm_actions, :alarm_name, :metric_name, :metric_namespace

  def initialize(opts = {})
    required_params = %i(metric_name metric_namespace)
    if opts.is_a?(String) || required_params.all? { |k| opts.key? k }
      raise ArgumentError, 'aws_cloudwatch_alarm requires metric_name and metric_namespace parameters to be specified'
    end

    super(opts)
    validate_parameters(required_params)

    @metric_name      = opts[:metric_name]
    @metric_namespace = opts[:metric_namespace]
    @alarm_actions    = []

    catch_aws_errors do
      resp = @aws.cloudwatch_client.describe_alarms_for_metric(metric_name: @metric_name, namespace: @metric_namespace)
      @metric_alarms = resp.metric_alarms
    end

    return false if @metric_alarms.empty?

    raise "Found multiple CloudWatch Alarms. The following matched: #{@metric_alarms.join(', ')}.  Try to restrict your resource criteria." if @metric_alarms.count > 1

    @alarm_actions = @metric_alarms.first.alarm_actions
    @alarm_name    = @metric_alarms.first.alarm_name
  end

  def exists?
    !@metric_alarms.nil?
  end

  def to_s
    "CloudWatch Alarm #{@metric_name} #{@metric_namespace}"
  end
end
