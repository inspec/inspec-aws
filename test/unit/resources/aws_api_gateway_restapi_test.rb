require 'helper'
require 'aws_api_gateway_restapi'
require 'aws-sdk-core'

class AWSApiGatewayRestApiConstructorTest < Minitest::Test

	def test_empty_params_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayRestApi.new(client_args: { stub_responses: true }) }
	end

	def test_empty_param_arg_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayRestApi.new(rest_api_id: '', client_args: { stub_responses: true }) }
	end

	def test_rejects_unrecognized_params
		assert_raises(ArgumentError) { AWSApiGatewayRestApi.new(unexpected: 9) }
	end
end

class AWSApiGatewayRestApiSuccessPathTest < Minitest::Test

	def setup
		data = {}
		data[:method] = :get_rest_api
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
		data[:data] = mock_data
		data[:client] = Aws::APIGateway::Client
		@res = AWSApiGatewayRestApi.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
	end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test1')
  end

	def test_api_gateway_restapi_exists
		assert @res.exists?
	end

	def test_id
		assert_equal(@res.id, 'test1')
	end

	def test_name
		assert_equal(@res.name, 'test1')
	end

  def test_description
    assert_equal(@res.description, 'test1')
  end

  def test_created_date
    assert_equal(@res.created_date, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_version
    assert_equal(@res.version, 'test1')
  end

  def test_warnings
    assert_equal(@res.warnings, ['test1'])
  end

  def test_binary_media_types
    assert_equal(@res.binary_media_types, ['test1'])
  end

  def test_minimum_compression_size
    assert_equal(@res.minimum_compression_size, 1)
  end

  def test_api_key_source
    assert_equal(@res.api_key_source, 'test1')
  end

  def test_endpoint_configuration
    assert_equal(@res.endpoint_configuration, {})
  end

  def test_policy
    assert_equal(@res.policy, 'test1')
  end

  def test_tags
    assert_equal(@res.tags, {})
  end

  def test_disable_execute_api_endpoint
    assert_equal(@res.disable_execute_api_endpoint, true)
  end
end