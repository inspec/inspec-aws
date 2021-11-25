require 'helper'
require 'aws_rds_db_security_group'
require 'aws-sdk-core'

class AWSRDSDBSecurityGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroup.new(db_security_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSDBSecurityGroup.new(unexpected: 9) }
  end
end

class AWSRDSDBSecurityGroupSuccessPathTest < Minitest::Test

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
    @resp = AWSRDSDBSecurityGroup.new(db_security_group_name: "test1", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_security_group_exist
    assert @resp.exists?
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_db_security_group_name
    assert_equal(@resp.db_security_group_name, 'test1')
  end

  def test_db_security_group_descriptions
    assert_equal(@resp.db_security_group_description, 'test1')
  end

  def test_ec2_security_group_names
    assert_equal(@resp.ec2_security_group_names, ['test1'])
  end
end