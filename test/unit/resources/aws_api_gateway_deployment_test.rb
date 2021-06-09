require 'helper'
require 'aws_api_gateway_deployment'
require 'aws-sdk-core'

class AWSApiGatewayDeploymentConstructorTest < Minitest::Test

	def test_empty_params_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayDeployment.new(client_args: { stub_responses: true }) }
	end

	def test_empty_param_arg_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayDeployment.new(rest_api_id: '', deployment_id: '', client_args: { stub_responses: true }) }
	end

	def test_rejects_unrecognized_params
		assert_raises(ArgumentError) { AWSApiGatewayDeployment.new(unexpected: 9) }
	end
end

class AWSApiGatewayDeploymentSuccessPathTest < Minitest::Test

	def setup
		data = {}
		data[:method] = :get_deployment
		mock_data = {}
		mock_data[:id] = 'test1'
		mock_data[:description] = 'test1'
		mock_data[:created_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
		mock_data[:api_summary] = {}
		data[:data] = [mock_data]
		data[:client] = Aws::APIGateway::Client
		@res = AWSApiGatewayDeployment.new(rest_api_id: 'test1', deployment_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
	end

	def test_api_gateway_deployment_exists
		assert @res.exists?
	end

	def test_id
		assert_equal(@res.id, 'test1')
	end

	def test_description
		assert_equal(@res.description, 'test1')
	end

	def test_created_date
		assert_equal(@res.created_date, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
	end

	def test_api_summary
		assert_equal(@res.api_summary, {})
	end
end