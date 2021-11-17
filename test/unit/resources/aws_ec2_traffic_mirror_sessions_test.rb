require 'helper'
require 'aws_ec2_traffic_mirror_sessions'
require 'aws-sdk-core'

class AwsEc2TrafficMirrorSessionsTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorSessions.new(rubbish: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorSessions.new('dummy') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2TrafficMirrorSessions.new(rubbish: 9) }
  end
end

class AwsEc2TrafficMirrorSessionsPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_traffic_mirror_sessions
    mock_lt = {}
    mock_lt[:traffic_mirror_session_id] = 'tms-01a6e9ac9f962f154'
    mock_lt[:traffic_mirror_target_id] = 'tmt-01a6e9ac9f962f154'
    mock_lt[:traffic_mirror_filter_id] = 'test-account'
    mock_lt[:network_interface_id] = 'dummy_id'
    mock_lt[:owner_id] = 'dummy_id'
    data[:data] = { :traffic_mirror_sessions => [mock_lt] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEc2TrafficMirrorSessions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_aws_ec2_traffic_mirror_sessions_exists
    assert @resp.exists?
  end

  def test_traffic_mirror_session_ids
    assert_equal(@resp.traffic_mirror_session_ids, ["tms-01a6e9ac9f962f154"])
  end

  def test_traffic_mirror_target_ids
    assert_equal(@resp.traffic_mirror_target_ids, ["tmt-01a6e9ac9f962f154"])
  end

  def test_traffic_mirror_filter_ids
    assert_equal(@resp.traffic_mirror_filter_ids, ['test-account'])
  end

  def test_network_interface_ids
    assert_equal(@resp.network_interface_ids, ['dummy_id'])
  end
end


