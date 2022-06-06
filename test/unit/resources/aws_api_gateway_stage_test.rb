require 'helper'
require 'aws_api_gateway_stage'
require 'aws-sdk-core'

class AWSApiGatewayStageConstructorTest < Minitest::Test

	def test_empty_params_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayStage.new(client_args: { stub_responses: true }) }
	end

	def test_empty_param_arg_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayStage.new(rest_api_id: '', stage_name: '', client_args: { stub_responses: true }) }
	end

	def test_rejects_unrecognized_params
		assert_raises(ArgumentError) { AWSApiGatewayStage.new(unexpected: 9) }
	end
end

class AWSApiGatewayStageSuccessPathTest < Minitest::Test

	def setup
		data = {}
		data[:method] = :get_stage
		mock_data = {}
		mock_data[:deployment_id]         = 'test1'
		mock_data[:stage_name]            = 'stage1'
		mock_data[:description]           = 'test1'
		mock_data[:client_certificate_id] = 'cert1'
		mock_data[:created_date]  = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
		data[:data] = [mock_data]
		data[:client] = Aws::APIGateway::Client
		@res = AWSApiGatewayStage.new(rest_api_id: 'test1', stage_name: 'stage1', client_args: { stub_responses: true }, stub_data: [data])
	end

	def test_resource_id
		refute_nil(@res.resource_id)
		assert_equal(@res.resource_id, 'stage1')
	end

	def test_stage_exists
		assert @res.exists?
	end

	def test_deployment_id
		assert_equal(@res.deployment_id, 'test1')
	end

    def test_stage_name
		assert_equal(@res.stage_name, 'stage1')
	end

	def test_description
		assert_equal(@res.description, 'test1')
	end

	def test_created_date
		assert_equal(@res.created_date, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
	end

	def test_client_certificate_id
		assert_equal(@res.client_certificate_id, 'cert1')
	end
end
