require 'helper'
require 'aws_api_gateway_documentation_versions'
require 'aws-sdk-core'

class AWSApiGatewayDocumentationVersionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayDocumentationVersions.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayDocumentationVersions.new('rubbish') }
  end

  def test_api_gateway_documentation_versions_non_existing_for_empty_response
    refute AWSApiGatewayDocumentationVersions.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayDocumentationVersionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_documentation_versions
    mock_data = {}
    mock_data[:version] = 'test'
    mock_data[:created_date] = Time.now()
    mock_data[:description] = 'test'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayDocumentationVersions.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_documentation_exists
    assert @resp.exist?
  end

  def test_versions
    assert_equal(@resp.versions, ['test'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test'])
  end
end