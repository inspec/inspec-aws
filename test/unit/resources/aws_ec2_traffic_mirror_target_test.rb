require 'helper'
require 'aws_ec2_traffic_mirror_target'
require 'aws-sdk-core'

class AwsEc2TrafficMirrorTargetTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorTarget.new(rubbish: 9,client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorTarget.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorTarget.new(rubbish: 9) }
  end

  def test_rejects_invalid_launch_template_endpoint_id
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorTarget.new(traffic_mirror_target_id: 'test') }
  end
end

class AwsEc2TrafficMirrorTargetPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_traffic_mirror_targets
    mock_lt = {}
    mock_lt[:traffic_mirror_target_id] = 'tmt-01a6e9ac9f962f154'
    mock_lt[:network_interface_id] = 'test-account'
    mock_lt[:network_load_balancer_arn] = 'dummy_id'
    mock_lt[:owner_id] = 'dummy_id'
    data[:data] = { :traffic_mirror_targets => [mock_lt] }
    data[:client] = Aws::EC2::Client
    @addr = AWSEc2TrafficMirrorTarget.new(traffic_mirror_target_id: 'tmt-01a6e9ac9f962f154',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_launch_template_exists
    assert @addr.exists?
  end

  def test_launch_template_name
    assert_equal(@addr.traffic_mirror_target_id, "tmt-01a6e9ac9f962f154")
  end

  def test_launch_template_id
    assert_equal(@addr.owner_id, "dummy_id")
  end

  def test_latest_version_number
    assert_equal(@addr.network_interface_id, 'test-account')
  end

  def test_default_version_number
    assert_equal(@addr.network_load_balancer_arn, 'dummy_id')
  end
end


