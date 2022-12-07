require 'aws_backend'

class AwsCloudwatchAnomalyDetector < AwsResourceBase
  name 'aws_cloudwatch_anomaly_detector'
  desc 'Lists the anomaly detection models that you have created in your account.'

  example "
    describe aws_cloudwatch_anomaly_detector(metric_name: 'METRIC_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { metric_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(metric_name))
    raise ArgumentError, "#{@__resource_name__}: metric_name must be provided" unless opts[:metric_name] && !opts[:metric_name].empty?
    @display_name = opts[:metric_name]
    catch_aws_errors do
      resp = @aws.cloudwatch_client.describe_anomaly_detectors({ metric_name: opts[:metric_name] })
      @res = resp.anomaly_detectors[0].to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@res? @res[:metric_name]: ''}_#{@res? @res[:namespace]: ''}"
  end

  def metric_name
    return nil unless exists?
    @res[:metric_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Metric Name: #{@display_name}"
  end

  def dimensions_names
    dimensions.map(&:name)
  end

  def dimensions_values
    dimensions.map(&:value)
  end

  def configuration_start_time
    configuration.map(&:excluded_time_ranges).map(&:start_time)
  end

  def configuration_end_time
    configuration.map(&:excluded_time_ranges).map(&:end_time)
  end
end
