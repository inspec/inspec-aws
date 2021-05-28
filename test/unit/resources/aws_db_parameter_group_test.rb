require 'helper'
require 'aws_db_parameter_group'
require 'aws-sdk-core'

class AwsDbParameterGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDbParameterGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsDbParameterGroup.new(db_parameter_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDbParameterGroup.new(unexpected: 9) }
  end

  def test_parameter_non_existing
    refute AwsDbParameterGroup.new(db_parameter_group_name: 'test-1', client_args: { stub_responses: true }).exists?
  end
end

class AwsDbParameterGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_parameter_groups
    mock_parameter = {}
    mock_parameter[:db_parameter_group_name] = 'test1'
    mock_parameter[:description] = 'test-description'
    mock_parameter[:db_parameter_group_family] = 'aurora-mysql5.7'
    mock_parameter[:db_parameter_group_arn] = 'arn:aws:rds:eu-west-1:112758395563:pg:test1'
    data[:data] = { db_parameter_groups: [mock_parameter] }
    data[:client] = Aws::RDS::Client
    @parameter_group = AwsDbParameterGroup.new(db_parameter_group_name: 'default', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @parameter_group.exists?
  end

  def test_db_parameter_group_name
    assert_equal(@parameter_group.db_parameter_group_name, 'test1')
  end

  def test_description
    assert_equal(@parameter_group.description, 'test-description')
  end

  def test_db_parameter_group_family
    assert_equal(@parameter_group.db_parameter_group_family, 'aurora-mysql5.7')
  end

  def test_db_parameter_group_arn
    assert_equal(@parameter_group.db_parameter_group_arn, 'arn:aws:rds:eu-west-1:112758395563:pg:test1')
  end
end