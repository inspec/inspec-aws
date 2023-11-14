require "aws_backend"

class AwsCloudFrontRealtimeLogConfig < AwsResourceBase
  name "aws_cloudfront_realtime_log_config"
  desc "Gets a real-time log configuration."
  example <<-EXAMPLE
    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[name])
    unless opts[:name] && !opts[:name].empty?
      raise ArgumentError, "#{@__resource_name__}: name must be provided"
    end
    @display_name = opts[:name]
    catch_aws_errors do
      resp =
        @aws.cloudfront_client.get_realtime_log_config({ name: opts[:name] })
      @res = resp.realtime_log_config.to_h
      @arn = @res[:arn]
      create_resource_methods(@res)
    end
  end

  def name
    return nil unless exists?
    @res[:name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def end_points_stream_types
    end_points.map(&:stream_type)
  end

  def end_points_kinesis_stream_config_role_arns
    end_points.map(&:kinesis_stream_config).map(&:role_arn)
  end

  def end_points_kinesis_stream_config_stream_arns
    end_points.map(&:kinesis_stream_config).map(&:stream_arn)
  end

  # Here we have used the arn as it is more unique than the name.
  def resource_id
    @arn
  end

  def to_s
    "Config Name: #{@display_name}"
  end
end
