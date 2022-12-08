require "aws_backend"

class AwsCloudwatchAlarm < AwsResourceBase
  name "aws_cloudwatch_alarm"
  desc "Verifies settings for an AWS CloudWatch Alarm."

  example "
  # Look for a specific alarm
  aws_cloudwatch_alarm(metric_name: 'my-metric-name', metric_namespace: 'my-metric-namespace') do
    it { should exist }
  end
  "

  attr_reader :alarm_actions, :alarm_name, :metric_name, :metric_namespace, :dimensions

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(dimensions), required: %i(metric_name metric_namespace))
    @metric_name      = opts[:metric_name]
    @metric_namespace = opts[:metric_namespace]
    @dimensions       = opts[:dimensions]
    @alarm_actions    = []
    alarm_parameters = {}
    alarm_parameters[:metric_name] = @metric_name
    alarm_parameters[:namespace] =   @metric_namespace
    if @dimensions
      # re-format the array of hashes to the required API format [{key => 'value'}] will become [{name => 'key' value => 'value'}]
      alarm_parameters[:dimensions] = []
      @dimensions.each do |dimension|
        dimension.each do |k, v|
          alarm_parameters[:dimensions] << { name: k, value: v }
        end
      end
    end

    catch_aws_errors do
      resp = @aws.cloudwatch_client.describe_alarms_for_metric(alarm_parameters)
      @metric_alarms = resp.metric_alarms
    end

    return false if @metric_alarms.empty?

    raise "Found multiple CloudWatch Alarms. The following matched: #{@metric_alarms.join(", ")}.  Try to restrict your resource criteria." if @metric_alarms.count > 1

    @alarm_actions = @metric_alarms.first.alarm_actions
    @alarm_name    = @metric_alarms.first.alarm_name
  end

  def resource_id
    "#{@metric_alarms? @metric_name: ""}_#{@metric_alarms? @metric_namespace: ""}"
  end

  def exists?
    !@metric_alarms.empty?
  end

  def to_s
    "CloudWatch Alarm #{@metric_name} #{@metric_namespace}"
  end
end
