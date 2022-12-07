require 'helper'
require 'aws_api_gateway_v2_domain_names'
require 'aws-sdk-core'

class AwsApiGatewayV2DomainNamesConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2DomainNames.new(client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2DomainNamesHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_domain_names
    mock_data = {}
    mock_data[:api_mapping_selection_expression] = 'test_api_mapping_selection_expression'
    mock_data[:domain_name] = 'test_domain_name'
    mock_data[:domain_name_configurations] = []
    mock_data[:mutual_tls_authentication] = {}
    mock_data[:tags] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2DomainNames.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_domain_name_exists
    assert @res.exists?
  end

  def test_api_mapping_selection_expressions
    assert_equal(@res.api_mapping_selection_expressions, ['test_api_mapping_selection_expression'])
  end

  def test_domain_names
    assert_equal(@res.domain_names, ['test_domain_name'])
  end

  def test_domain_name_configurations
    assert_equal(@res.domain_name_configurations, [])
  end

  def test_mutual_tls_authentications
    assert_equal(@res.mutual_tls_authentications, [{}])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end
end
