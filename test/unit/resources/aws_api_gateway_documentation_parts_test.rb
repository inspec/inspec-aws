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

  def test_items_non_existing_for_empty_response
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
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @items = AWSApiGatewayDocumentationParts.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @items.exist?
  end

  def test_ids
    assert_equal(@items.ids, ['test'])
  end

  def test_path
    assert_equal(@items.paths, ['test'])
  end

  def test_status_code
    assert_equal(@items.status_codes, ['test'])
  end
end