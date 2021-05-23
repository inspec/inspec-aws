# require 'helper'
# require 'aws_lambda_function'
# require 'aws-sdk-core'

# class AWSLambdaFunctionConstructorTest < Minitest::Test

#   def test_empty_params_not_ok
#     assert_raises(ArgumentError) { AWSLambdaFunction.new(client_args: { stub_responses: true }) }
#   end

#   def test_empty_param_arg_not_ok
#     assert_raises(ArgumentError) { AWSLambdaFunction.new(function_name: '', client_args: { stub_responses: true }) }
#   end

#   def test_rejects_unrecognized_params
#     assert_raises(ArgumentError) { AWSLambdaFunction.new(unexpected: 9) }
#   end
# end

# class AWSLambdaFunctionSuccessPathTest < Minitest::Test

#   def setup
#     data = {}
#     data[:method] = :get_function
#     mock_parameter = {}
#     mock_parameter[:name] = 'test1'
#     mock_parameter[:state] = 'test1'
#     mock_parameter[:description] = 'test1'
#     data[:data] = { configuration: mock_parameter }
#     data[:client] = Aws::Lambda::Client
#     @configuration = AWSLambdaFunction.new(function_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
#   end

#   def test_parameter_group_exists
#     assert @configuration.exists?
#   end

#   def test_name
#     assert_equal(@configuration.name, 'test1')
#   end

#   def test_state
#     assert_equal(@configuration.state, 'test1')
#   end

#   def test_description
#     assert_equal(@configuration.description, 'test1')
#   end
# end