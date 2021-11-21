# frozen_string_literal: true

require 'aws_backend'

class AWSMQConfiguration < AwsResourceBase
  name 'aws_mq_configuration'
  desc 'Describes a Amazon MQ configuration.'

  example "
    describe aws_mq_configuration(configuration_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { configuration_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:configuration_id])

    raise ArgumentError, "#{@__resource_name__}: configuration_id must be provided" unless opts[:configuration_id] && !opts[:configuration_id].empty?
    @display_name = opts[:configuration_id]
    resp = @aws.mq_client.describe_configuration({ configuration_id: opts[:configuration_id] })
    @configurations = resp.to_h
    create_resource_methods(@configurations)
  end

  def configuration_id
    return nil unless exists?
    @configurations[:configuration_id]
  end

  def exists?
    !@configurations.nil? && !@configurations.empty?
  end

  def to_s
    "Configuration ID: #{@display_name}"
  end
end
