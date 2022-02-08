require 'helper'
require 'aws_api_gateway_documentation_part'
require 'aws-sdk-core'

class AWSApiGatewayDocumentationPartConstructorTest < Minitest::Test

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
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @items = AWSApiGatewayDocumentationPart.new(rest_api_id: 'test1', documentation_part_id: 'test1' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @items.exist?
  end

  def test_ids
    assert_equal(@items.id, 'test')
  end

  def test_path
    assert_equal(@items.location.path, 'test')
  end

  def test_status_code
    assert_equal(@items.location.status_code, 'test')
  end
end