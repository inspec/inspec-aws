require 'helper'
require 'aws_api_gateway_documentation_parts'
require 'aws-sdk-core'

class AWSApiGatewayDocumentationPartsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayDocumentationParts.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayDocumentationParts.new('rubbish') }
  end

  def test_api_gateway_documentation_parts_non_existing_for_empty_response
    refute AWSApiGatewayDocumentationParts.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayDocumentationPartsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_documentation_parts
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:location] = { type: "test", path: "test", method: "test", status_code: "test"}
    mock_data[:properties] = 'test'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayDocumentationParts.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_documentation_parts_exists
    assert @resp.exist?
  end

  def test_ids
    assert_equal(@resp.ids, ['test'])
  end

  def test_location_types
    assert_equal(@resp.types, ['test'])
  end

  def test_location_paths
    assert_equal(@resp.paths, ['test'])
  end

  def test_location_methods
    assert_equal(@resp.methods, ['test'])
  end

  def test_location_status_codes
    assert_equal(@resp.status_codes, ['test'])
  end

  def test_properties
    assert_equal(@resp.properties, ['test'])
  end
end