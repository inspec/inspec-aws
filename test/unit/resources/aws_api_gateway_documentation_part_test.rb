require 'helper'
require 'aws_api_gateway_documentation_part'
require 'aws-sdk-core'

class AWSApiGatewayDocumentationPartConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayDocumentationPart.new(client_args: { stub_responses: true }) }
  end

  def test_params_ok
    AWSApiGatewayDocumentationPart.new(rest_api_id: 'test1', documentation_part_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayDocumentationPart.new('rubbish') }
  end
end

class AWSApiGatewayDocumentationPartHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_documentation_part
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:location] = { type: "test", path: "test", method: "test", status_code: "test"}
    mock_data[:properties] = 'test'
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayDocumentationPart.new(rest_api_id: 'test1', documentation_part_id: 'test1' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test')
  end

  def test_documentation_part_exists
    assert @resp.exist?
  end

  def test_ids
    assert_equal(@resp.id, 'test')
  end

  def test_location_type
    assert_equal(@resp.location.type, 'test')
  end

  def test_location_path
    assert_equal(@resp.location.path, 'test')
  end

  def test_location_method
    assert_equal(@resp.location.method, 'test')
  end

  def test_location_status_code
    assert_equal(@resp.location.status_code, 'test')
  end

  def test_properties
    assert_equal(@resp.properties, 'test')
  end
end