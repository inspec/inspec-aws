require "aws_backend"

class AWSMQConfiguration < AwsResourceBase
  name "aws_mq_configuration"
  desc "Returns information about the specified configuration."
  example <<-EXAMPLE
    describe aws_mq_configuration(configuration_id: 'CONFIGURATION_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { configuration_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(configuration_id))
    raise ArgumentError, "#{@__resource_name__}: configuration_id must be provided" if opts[:configuration_id].blank?
    @display_name = opts[:configuration_id]
    catch_aws_errors do
      resp = @aws.mq_client.describe_configuration({ configuration_id: opts[:configuration_id] })
      @configurations = resp.to_h
      @arn = @configurations[:arn]
      create_resource_methods(@configurations)
    end
  end

  def resource_id
    return unless exists?

    @arn || @display_name
  end

  def exists?
    !@configurations.blank?
  end

  def configuration_id
    return nil unless exists?
    @configurations[:id]
  end

  def to_s
    "Configuration ID: #{@display_name}"
  end
end
