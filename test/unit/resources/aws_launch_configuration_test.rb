require 'aws-sdk-core'
require 'aws_launch_configuration'
require 'helper'
require_relative 'mock/aws_launch_configuration_mock'

class AwsLaunchConfigurationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsLaunchConfiguration.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_config_name
    AwsLaunchConfiguration.new(launch_configuration_name: 'my-config', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsLaunchConfiguration.new(rubbish: 9) }
  end

  def test_launch_configuration_not_existing
    refute AwsLaunchConfiguration.new(launch_configuration_name: 'my-config', client_args: { stub_responses: true }).exists?
  end
end

class AwsLaunchConfigurationTest < Minitest::Test

  def setup
    # Given
    @mock = AwsLaunchConfigurationMock.new
    @mock_config = @mock.configuration

    # When
    @config = AwsLaunchConfiguration.new(launch_configuration_name: "my-config",
                            client_args: { stub_responses: true },
                            stub_data: @mock.stub_data)
  end

  def test_exists
    assert @config.exists?
  end

  def test_launch_configuration_arn
    assert_equal(@config.arn, @mock_config[:launch_configurations].first[:launch_configuration_arn])
  end

  def test_launch_configuration_name
    assert_equal(@config.name, @mock_config[:launch_configurations].first[:launch_configuration_name])
  end

  def test_image_id
    assert_equal(@config.image_id, @mock_config[:launch_configurations].first[:image_id])
  end

  def test_instance_type
    assert_equal(@config.instance_type, @mock_config[:launch_configurations].first[:instance_type])
  end

  def test_iam_instance_profile
    assert_equal(@config.iam_instance_profile, @mock_config[:launch_configurations].first[:iam_instance_profile])
  end

  def test_key_name
    assert_equal(@config.key_name, @mock_config[:launch_configurations].first[:key_name])
  end

  def test_security_groups
    assert_equal(@config.security_groups, @mock_config[:launch_configurations].first[:security_groups])
  end

  def test_ebs_optimized
    assert_equal(@config.ebs_optimized, @mock_config[:launch_configurations].first[:ebs_optimized])
  end

  def test_spot_price
    assert_equal(@config.spot_price, @mock_config[:launch_configurations].first[:spot_price].to_f)
  end

  def test_instance_monitoring
    assert_equal(@config.instance_monitoring, 'detailed')
  end

  def test_user_data
    assert_equal(@config.user_data, Base64.decode64(@mock_config[:launch_configurations].first[:user_data]))
  end
end