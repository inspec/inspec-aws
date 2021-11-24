require 'helper'
require 'aws_network_manager_global_networks'
require 'aws-sdk-core'

class AWSNetworkManagerGlobalNetworksConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSNetworkManagerGlobalNetworks.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSNetworkManagerGlobalNetworks.new('rubbish') }
  end

  def test_global_networks_non_existing_for_empty_response
    refute AWSNetworkManagerGlobalNetworks.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSNetworkManagerGlobalNetworksHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_global_networks
    mock_data = {}
    mock_data[:global_network_id] = 'test1'
    mock_data[:global_network_arn] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:created_at] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:state] = 'test1'
    data[:data] = { :global_networks => [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerGlobalNetworks.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_global_network_ids
    assert_equal(@resp.global_network_ids, ['test1'])
  end

  def test_global_network_arns
    assert_equal(@resp.global_network_arns, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_created_at
    assert_equal(@resp.created_at, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end
end