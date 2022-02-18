require 'helper'
require 'aws_rds_db_security_groups'
require 'aws-sdk-core'

class AWSRDSDBSecurityGroupsConstructorTest < Minitest::Test

  def test_non_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroups.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroups.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroups.new(unexpected: 9) }
  end
end

class AWSRDSDBSecurityGroupsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_security_groups
    mock_data = {}
    mock_data[:owner_id] = 'test1'
    mock_data[:db_security_group_name] = 'test1'
    mock_data[:db_security_group_description] = 'test1'
    mock_data[:ec2_security_groups] = [
      ec2_security_group_name: 'test1',
      ec2_security_group_id: 'test1',
      ec2_security_group_owner_id: 'test1'
    ]
    mock_data[:db_security_group_arn] = 'test1'
    data[:data] = { db_security_groups: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSDBSecurityGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_security_groups_exist
    assert @resp.exists?
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_db_security_group_names
    assert_equal(@resp.db_security_group_names, ['test1'])
  end

  def test_db_security_group_descriptions
    assert_equal(@resp.db_security_group_descriptions, ['test1'])
  end
end