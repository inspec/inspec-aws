# require 'helper'
# require 'aws_api_gateway_request_validators'
# require 'aws-sdk-core'
#
# class AWSApiGatewayRequestValidatorsConstructorTest < Minitest::Test
#
#   def test_empty_params_not_ok
#     assert_raises(ArgumentError) { AWSApiGatewayRequestValidators.new(rest_api_id: '', client_args: { stub_responses: true }) }
#   end
#
#   def test_empty_param_arg_not_ok
#     assert_raises(ArgumentError) { AWSApiGatewayRequestValidators.new(rest_api_id: '', client_args: { stub_responses: true }) }
#   end
#
#   def test_rejects_unrecognized_params
#     assert_raises(ArgumentError) { AWSApiGatewayRequestValidators.new(unexpected: 9) }
#   end
# end
#
# class AWSApiGatewayRequestValidatorsSuccessPathTest < Minitest::Test
#
#   def setup
#     data = {}
#     data[:method] = :get_request_validators
#     mock_data = {}
#     mock_data[:id] = 'test'
#     mock_data[:name] = 'test'
#     mock_data[:validate_request_body] = true
#     mock_data[:validate_request_parameters] = true
#     data[:data] = { :items => [mock_data] }
#     data[:client] = Aws::APIGateway::Client
#     @res = AWSApiGatewayRequestValidators.new(rest_api_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
#   end
#
#   def test_request_validators_exists
#     assert @res.exists?
#   end
#
#   def test_ids
#     assert_equal(@res.ids, ['test'])
#   end
#
#   def test_names
#     assert_equal(@res.names, ['test'])
#   end
#
#   def test_validate_request_bodies
#     assert_equal(@res.validate_request_bodies, [true])
#   end
#
#   def test_validate_request_parameters
#     assert_equal(@res.validate_request_parameters, [true])
#   end
# end