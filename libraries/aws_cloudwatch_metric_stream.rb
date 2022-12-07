require 'aws_backend'

class AWSCloudwatchMetricStream < AwsResourceBase
  name 'aws_cloudwatch_metric_stream'
  desc 'Returns the configuration information and metadata of the specified cloudwatch stream.'

  example "
    describe aws_cloudwatch_metric_stream (metric_stream_name: 'MetricStreamName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { metric_stream_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:metric_stream_name])
    raise ArgumentError, "#{@__resource_name__}: metric_stream_name must be provided" unless opts[:metric_stream_name] && !opts[:metric_stream_name].empty?
    @display_name = opts[:metric_stream_name]
    catch_aws_errors do
      resp = @aws.cloudwatch_client.get_metric_stream({ name: opts[:metric_stream_name] })
      @stream = resp.to_h
      @stream_name = @stream[:name]
      @stream_arn = @stream[:arn]
      create_resource_methods(@stream)
    end
  end

  def resource_id
    "#{@stream_name}_#{@stream_arn}"
  end

  def metric_stream_name
    return nil unless exists?
    @stream[:name]
  end

  def exists?
    !@stream.nil? && !@stream.empty?
  end

  def to_s
    "Metric Stream Name: #{@display_name}"
  end
end
