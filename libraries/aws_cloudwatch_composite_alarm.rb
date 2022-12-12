require "aws_backend"

class AwsCloudwatchCompositeAlarm < AwsResourceBase
  name "aws_cloudwatch_composite_alarm"
  desc "Gets a composite alarm."
  example <<-EXAMPLE
    describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { alarm_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(alarm_name))
    raise ArgumentError, "#{@__resource_name__}: alarm_name must be provided" unless opts[:alarm_name] && !opts[:alarm_name].empty?
    @display_name = opts[:alarm_name]
    catch_aws_errors do
      resp = @aws.cloudwatch_client.describe_alarms({ alarm_names: [opts[:alarm_name]], alarm_types: ["CompositeAlarm"] })
      @res = resp.composite_alarms[0].to_h
      @alarm_arn = @res[:alarm_arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @alarm_arn
  end

  def alarm_name
    return nil unless exists?
    @res[:alarm_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Composite Alarm Name: #{@display_name}"
  end
end
