require 'helper'
require 'aws_db_parameter_groups'
require 'aws-sdk-core'

class AwsDbParameterGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsDbParameterGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsDbParameterGroups.new('rubbish') }
  end

  def test_subnets_non_existing_for_empty_response
    refute AwsDbParameterGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsDbParameterGroupsSuccessPathTest < Minitest::Test

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
    @parameter_groups = AwsDbParameterGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_groups_exist
    assert @parameter_groups.exist?
  end

  def test_db_parameter_group_names
    assert_equal(@parameter_groups.db_parameter_group_names, ['test1'])
  end

  def test_descriptions
    assert_equal(@parameter_groups.descriptions, ['test-description'])
  end

  def test_db_parameter_group_families
    assert_equal(@parameter_groups.db_parameter_group_families, ['aurora-mysql5.7'])
  end

  def test_db_parameter_group_arns
    assert_equal(@parameter_groups.db_parameter_group_arns, ['arn:aws:rds:eu-west-1:112758395563:pg:test1'])
  end
end