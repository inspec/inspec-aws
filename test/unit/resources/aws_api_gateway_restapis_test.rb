require 'helper'
require 'aws_api_gateway_restapis'
require 'aws-sdk-core'

class AWSApiGatewayRestApisConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayRestApis.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayRestApis.new('rubbish') }
  end

  def test_api_gateway_restapis_non_existing_for_empty_response
    refute AWSApiGatewayRestApis.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayRestApisHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_rest_apis
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:created_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:version] = 'test1'
    mock_data[:warnings] = ['test1']
    mock_data[:binary_media_types] = ['test1']
    mock_data[:minimum_compression_size] = 1
    mock_data[:api_key_source] = 'test1'
    mock_data[:endpoint_configuration] = {}
    mock_data[:policy] = 'test1'
    mock_data[:tags] = {}
    mock_data[:disable_execute_api_endpoint] = true
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayRestApis.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_items_exists
    assert @res.exist?
  end

  def test_ids
    assert_equal(@res.ids, ['test1'])
  end

  def test_names
    assert_equal(@res.names, ['test1'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test1'])
  end

  def test_created_dates
    assert_equal(@res.created_dates, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_versions
    assert_equal(@res.versions, ['test1'])
  end

  def test_warnings
    assert_equal(@res.warnings, [['test1']])
  end

  def test_binary_media_types
    assert_equal(@res.binary_media_types, [['test1']])
  end

  def test_minimum_compression_sizes
    assert_equal(@res.minimum_compression_sizes, [1])
  end

  def test_api_key_sources
    assert_equal(@res.api_key_sources, ['test1'])
  end

  def test_endpoint_configurations
    assert_equal(@res.endpoint_configurations, [{}])
  end

  def test_policies
    assert_equal(@res.policies, ['test1'])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end

  def test_disable_execute_api_endpoints
    assert_equal(@res.disable_execute_api_endpoints, [true])
  end
end