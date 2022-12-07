require 'aws_backend'

class AwsLaunchConfiguration < AwsResourceBase
  name 'aws_launch_configuration'
  desc 'Verifies settings for an AWS Launch Configuration.'

  example "
    describe aws_launch_configuration('config-name') do
      it { should exist }
    end
  "

  attr_reader :name, :arn, :image_id, :instance_type, :iam_instance_profile, :key_name, :security_groups, :associate_public_ip_address,
              :ebs_optimized, :spot_price, :instance_monitoring, :user_data

  def initialize(opts = {})
    opts = { launch_configuration_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:launch_configuration_name])

    catch_aws_errors do
      resp = @aws.service_client.describe_launch_configurations(launch_configuration_names: [opts[:launch_configuration_name]])
      return nil if resp.launch_configurations.nil? || resp.launch_configurations.empty?
      configuration = resp.launch_configurations[0]
      @name                        = configuration[:launch_configuration_name]
      @arn                         = configuration[:launch_configuration_arn]
      @image_id                    = configuration[:image_id]
      @instance_type               = configuration[:instance_type]
      @iam_instance_profile        = configuration[:iam_instance_profile]
      @key_name                    = configuration[:key_name]
      @security_groups             = configuration[:security_groups]
      @associate_public_ip_address = configuration[:associate_public_ip_address].nil? ? false : true
      @ebs_optimized               = configuration[:ebs_optimized]
      @spot_price                  = configuration[:spot_price].to_f
      @instance_monitoring         = configuration[:instance_monitoring][:enabled] ? 'detailed': 'basic'
      @user_data                   = configuration[:user_data] ? Base64.decode64(configuration[:user_data]) : nil
    end
  end

  def exists?
    !@name.nil?
  end

  def resource_id
    @arn
  end

  def to_s
    "AWS Launch Configuration Name: #{@name}"
  end
end
