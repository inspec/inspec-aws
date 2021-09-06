require 'helper'
require 'aws_network_manager_global_network'
require 'aws-sdk-core'

class AWSNetworkManagerGlobalNetworkConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerGlobalNetwork.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerGlobalNetwork.new(global_network_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkManagerGlobalNetwork.new(unexpected: 9) }
  end
end

class AWSNetworkManagerGlobalNetworkSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_global_networks
    mock_data = {}
    mock_data[:global_network_id] = 'test1'
    mock_data[:global_network_arn] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:created_at] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:state] = 'test1'
    data[:data] = { global_networks: [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerGlobalNetwork.new(global_network_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_global_networks_exists
    assert @resp.exists?
  end

  def test_global_network_id
    assert_equal(@resp.global_network_id, 'test1')
  end

  def test_global_network_arn
    assert_equal(@resp.global_network_arn, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_created_at
    assert_equal(@resp.created_at, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

end