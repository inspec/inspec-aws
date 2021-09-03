require 'helper'
require 'aws_network_manager_customer_gateway_associations'
require 'aws-sdk-core'

class AWSNetworkManagerCustomerGatewayAssociationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSNetworkManagerCustomerGatewayAssociations.new(global_network_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSNetworkManagerCustomerGatewayAssociations.new('rubbish') }
  end

  def test_customer_gateway_associations_request_configs_non_existing_for_empty_response
    refute AWSNetworkManagerCustomerGatewayAssociations.new(global_network_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSNetworkManagerCustomerGatewayAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_customer_gateway_associations
    mock_data = {}
    mock_data[:customer_gateway_arn] = 'test1'
    mock_data[:global_network_id] = 'test1'
    mock_data[:device_id] = 'test1'
    mock_data[:link_id] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { :customer_gateway_associations => [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerCustomerGatewayAssociations.new(global_network_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_customer_gateway_arns
    assert_equal(@resp.customer_gateway_arns,  ['test1'])
  end

  def test_global_network_ids
    assert_equal(@resp.global_network_ids,  ['test1'])
  end

  def test_device_ids
    assert_equal(@resp.device_ids,  ['test1'])
  end

  def test_link_ids
    assert_equal(@resp.link_ids,  ['test1'])
  end

  def test_states
    assert_equal(@resp.states,  ['test1'])
  end
end