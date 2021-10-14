# frozen_string_literal: true

require 'aws_backend'

class AWSCloudWatchLogsDestination < AwsResourceBase
  name 'aws_cloudwatch_logs_destination'
  desc 'Describes one or more of your logs destination.'

  example "
    describe aws_cloudwatch_logs_destination(destination_name_prefix: 'Destination_Name') do
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
      create_resource_methods(@destinations)
    end
  end

  def destination_name_prefix
    return nil unless exists?
    @destinations[:destination_name_prefix]
  end

  def exists?
    !@destinations.nil? && !@destinations.empty?
  end

  def to_s
    " Destination Name: #{@display_name}"
  end
end
