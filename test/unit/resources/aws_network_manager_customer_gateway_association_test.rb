require 'helper'
require 'aws_network_manager_customer_gateway_association'
require 'aws-sdk-core'

class AWSNetworkManagerCustomerGatewayAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerCustomerGatewayAssociation.new(global_network_id: '', customer_gateway_arn: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerCustomerGatewayAssociation.new(global_network_id: '', customer_gateway_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkManagerCustomerGatewayAssociation.new(unexpected: 9) }
  end
end

class AWSNetworkManagerCustomerGatewayAssociationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_customer_gateway_associations
    mock_data = {}
    mock_data[:customer_gateway_arn] = 'test1'
    mock_data[:global_network_id] = 'test1'
    mock_data[:device_id] = 'test1'
    mock_data[:link_id] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { customer_gateway_associations: [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerCustomerGatewayAssociation.new(global_network_id: 'test1', customer_gateway_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_customer_gateway_associations_configs_exists
    assert @resp.exists?
  end

  def test_customer_gateway_arn
    assert_equal(@resp.customer_gateway_arn,  'test1')
  end

  def test_global_network_id
    assert_equal(@resp.global_network_id,  'test1')
  end

  def test_device_id
    assert_equal(@resp.device_id,  'test1')
  end

  def test_link_id
    assert_equal(@resp.link_id,  'test1')
  end

  def test_state
    assert_equal(@resp.state,  'test1')
  end
end