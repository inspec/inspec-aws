require_relative 'aws_base_resource_mock'

class AwsLaunchConfigurationMock < AwsBaseResourceMock

  def initialize
    super
    @launch_configurations = {launch_configurations: [{launch_configuration_name: @aws.any_string,
                               launch_configuration_arn: @aws.any_arn,
                               image_id: @aws.any_id,
                               instance_type: @aws.any_string,
                               iam_instance_profile: @aws.any_string,
                               key_name: @aws.any_arn,
                               security_groups: [],
                               associate_public_ip_address: false,
                               ebs_optimized: false,
                               spot_price: '0.4',
                               instance_monitoring: {:enabled=>true},
                               user_data: Base64.encode64(@aws.any_string),
                               created_time: @aws.any_date}]}
  end

  def stub_data
    stub_data = []

    config = {:client => Aws::AutoScaling::Client,
             :method => :describe_launch_configurations,
             :data => @launch_configurations}

    stub_data += [config]
  end

  def configuration
    @launch_configurations
  end
end