require 'helper'
require 'aws_api_gateway_documentation_version'
require 'aws-sdk-core'

class AWSApiGatewayDocumentationVersionConstructorTest < Minitest::Test

  def test_params_ok
    AWSApiGatewayDocumentationVersion.new(rest_api_id: 'test', documentation_version: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayDocumentationVersion.new('rubbish') }
  end
end

class AWSApiGatewayDocumentationVersionHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_documentation_version
    mock_data = {}
    mock_data[:version] = 'test'
    mock_data[:created_date] = Time.now()
    mock_data[:description] = 'test'
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayDocumentationVersion.new(rest_api_id: 'test', documentation_version: 'test' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test')
  end

  def test_documentation_exists
    assert @resp.exist?
  end

  def test_version
    assert_equal(@resp.version, 'test')
  end

  def test_description
    assert_equal(@resp.description, 'test')
  end

end