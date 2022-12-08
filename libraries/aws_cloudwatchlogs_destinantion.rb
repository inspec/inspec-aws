require "aws_backend"

class AWSCloudWatchLogsDestination < AwsResourceBase
  name "aws_cloudwatchlogs_destination"
  desc "Describes a log destination."

  example "
    describe aws_cloudwatchlogs_destination(destination_name_prefix: 'DESTINATION_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { destination_name_prefix: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:destination_name_prefix])
    raise ArgumentError, "#{@__resource_name__}: destination_name_prefix must be provided" unless opts[:destination_name_prefix] && !opts[:destination_name_prefix].empty?
    @display_name = opts[:destination_name_prefix]
    catch_aws_errors do
      resp = @aws.cloudwatchlogs_client.describe_destinations({ destination_name_prefix: opts[:destination_name_prefix] })
      @destinations = resp.destinations[0].to_h
      @destination_name = @destinations[:destination_name]
      @destination_arn = @destinations[:arn]
      create_resource_methods(@destinations)
    end
  end

  def resource_id
    "#{@destination_name}_#{@destination_arn}"
  end

  def destination_name_prefix
    return nil unless exists?
    @destinations[:destination_name_prefix]
  end

  def exists?
    !@destinations.nil? && !@destinations.empty?
  end

  def to_s
    "Destination Name: #{@display_name}"
  end
end
