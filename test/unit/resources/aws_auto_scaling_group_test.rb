require 'aws-sdk-core'
require 'helper'
require 'aws_auto_scaling_group'
require_relative 'mock/aws_auto_scaling_group_mock'

class AwsAutoScalingGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsAutoScalingGroup.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_group_name
    AwsAutoScalingGroup.new(auto_scaling_group_name: 'my-group', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsAutoScalingGroup.new(rubbish: 9) }
  end

  def test_auto_scaling_group_not_existing
    refute AwsAutoScalingGroup.new(auto_scaling_group_name: 'my-group', client_args: { stub_responses: true }).exists?
  end
end

class AwsAutoScalingGroupTest < Minitest::Test

  def setup
    # Given
    @mock = AwsAutoScalingGroupMock.new
    @mock_config = @mock.auto_scaling_group

    # When
    @config = AwsAutoScalingGroup.new(auto_scaling_group_name: "my-group",
                                         client_args: { stub_responses: true },
                                         stub_data: @mock.stub_data)
  end

  def test_exists
    assert @config.exists?
  end

  def test_auto_scaling_group_name
    assert_equal(@config.name, @mock_config[:auto_scaling_groups].first[:auto_scaling_group_name])
  end

  def test_min_size
    assert_equal(@config.min_size, @mock_config[:auto_scaling_groups].first[:min_size].to_i)
  end

  def test_max_size
    assert_equal(@config.max_size, @mock_config[:auto_scaling_groups].first[:max_size].to_i)
  end

  def test_desired_capacity
    assert_equal(@config.desired_capacity, @mock_config[:auto_scaling_groups].first[:desired_capacity].to_i)
  end

  def test_vpc_zone_identifier
    assert_equal(@config.vpc_zone_identifier, @mock_config[:auto_scaling_groups].first[:vpc_zone_identifier].split(','))
  end

  def test_launch_configuration_name
    assert_equal(@config.launch_configuration_name, @mock_config[:auto_scaling_groups].first[:launch_configuration_name])
  end

  def test_tags
    assert_equal(@config.tags, @mock_config[:auto_scaling_groups].first[:tags])
  end

  def test_health_check_type
    assert_equal(@config.health_check_type, @mock_config[:auto_scaling_groups].first[:health_check_type])
  end
end