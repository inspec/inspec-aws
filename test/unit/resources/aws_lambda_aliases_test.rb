require 'helper'
require 'aws_lambda_aliases'
require 'aws-sdk-core'

class AWSLambdaAliasesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLambdaAliases.new(function_name: 'test1', client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaAliases.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaAliases.new(unexpected: 9) }
  end
end

class AWSLambdaAliasesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_aliases
    mock_data = {}
    mock_data[:alias_arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:function_version] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:routing_config] = {}
    mock_data[:revision_id] = 'test1'
    data[:data] = { :aliases => [mock_data] }
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaAliases.new(function_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_aliases_exist
    assert @resp.exists?
  end

  def test_alias_arns
    assert_equal(@resp.alias_arns, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_function_versions
    assert_equal(@resp.function_versions, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_revision_ids
    assert_equal(@resp.revision_ids, ['test1'])
  end
end