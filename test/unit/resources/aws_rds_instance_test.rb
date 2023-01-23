require 'helper'
require 'aws_rds_instance'
require 'aws-sdk-core'

class AwsRdsInstanceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsRdsInstance.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsRdsInstance.new('*rubbish*') }
  end

  def test_accepts_valid_db_instance_identifier
    AwsRdsInstance.new(db_instance_identifier: 'rds-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRdsInstance.new(rubbish: 9) }
  end

  def test_rejects_invalid_db_instance_identifier
    assert_raises(ArgumentError) { AwsRdsInstance.new(db_instance_identifier: 'rds_rubbish') }
  end

  def test_db_instances_non_existing
    refute AwsRdsInstance.new(db_instance_identifier: 'rds-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsRdsInstanceTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_instances
    mock_rds = {}
    mock_rds[:db_instance_identifier] = 'rds-12345678'
    mock_rds[:allocated_storage] = 100
    mock_rds[:db_instance_class] = 'db.t3.micro'
    mock_rds[:engine] = 'mysql'
    mock_rds[:engine_version] = '1.2.3'
    mock_rds[:master_username] = 'starlord'
    mock_rds[:db_name] = 'starlorddb'
    data[:data] = { :db_instances => [mock_rds] }
    data[:client] = Aws::RDS::Client
    @rds = AwsRdsInstance.new(db_instance_identifier: 'rds-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@rds.resource_id)
    assert_equal(@rds.resource_id, @rds.db_instance_identifier + '_' + @rds.db_name + '_' + @rds.master_username)
  end

  def test_rds_exists
    assert @rds.exists?
  end

  def test_db_id
    assert_equal(@rds.db_instance_identifier,  'rds-12345678')
  end

  def test_db_storage
    assert_equal(@rds.allocated_storage, 100)
  end

  def test_rds_class
    assert_equal(@rds.db_instance_class, 'db.t3.micro')
  end

  def test_rds_engine
    assert_equal(@rds.engine, 'mysql')
  end

  def test_rds_engine_version
    assert_equal(@rds.engine_version, '1.2.3')
  end

  def test_rds_user
    assert_equal(@rds.master_username, 'starlord')
  end

  def test_rds_name
    assert_equal(@rds.db_name, 'starlorddb')
  end
end
