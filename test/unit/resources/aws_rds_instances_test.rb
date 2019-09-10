require 'helper'
require 'aws_rds_instances'
require 'aws-sdk-core'

class AwsRdsInstancesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsRdsInstances.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsInstances.new('rubbish') }
  end

  def test_instances_non_existing_for_empty_response
    refute AwsRdsInstances.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsRdsInstancesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_instances
    mock_instance = {}
    mock_instance[:db_instance_identifier] = 'rds-012b75749d0b5ceb5'
    data[:data] = { :db_instances => [mock_instance] }
    data[:client] = Aws::RDS::Client
    @instances = AwsRdsInstances.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_instances_exists
    assert @instances.exist?
  end

  def test_instances_ids
    assert_equal(@instances.db_instance_identifiers, ['rds-012b75749d0b5ceb5'])
  end

  def test_instances_filtering_not_there
    refute @instances.where(:db_instance_identifier => 'bad').exist?
  end

  def test_instances_filtering_there
    assert @instances.where(:db_instance_identifier => 'rds-012b75749d0b5ceb5').exist?
  end
end
