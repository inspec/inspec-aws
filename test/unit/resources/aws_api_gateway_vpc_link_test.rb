require 'helper'
require 'aws_api_gateway_vpc_link'
require 'aws-sdk-core'

class AWSApiGatewayVPCLinkConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayVPCLink.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayVPCLink.new(vpc_link_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayVPCLink.new(unexpected: 9) }
  end
end

class AWSApiGatewayVPCLinkSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_vpc_link
    mock_data = {}
    mock_data[:id] = 'test_id'
    mock_data[:name] = 'test_name'
    mock_data[:description] = 'test_description'
    mock_data[:target_arns] = ['test_target_arn']
    mock_data[:status] = 'test_status'
    mock_data[:status_message] = 'test_status_message'
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayVPCLink.new(vpc_link_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.id+'_'+@res.name)
  end
  
  def test_vpc_link_exists
    assert @res.exists?
  end
  
  def test_id
    assert_equal(@res.id, 'test_id')
  end
  
  def test_name
    assert_equal(@res.name, 'test_name')
  end
  
  def test_description
    assert_equal(@res.description, 'test_description')
  end
  
  def test_target_arns
    assert_equal(@res.target_arns, ['test_target_arn'])
  end
  
  def test_status
    assert_equal(@res.status, 'test_status')
  end
  
  def test_status_message
    assert_equal(@res.status_message, 'test_status_message')
  end
end
