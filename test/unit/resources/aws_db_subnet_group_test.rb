require 'helper'
require 'aws_db_subnet_group'
require 'aws-sdk-core'

class AwsDbSubnetGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDbSubnetGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsDbSubnetGroup.new(db_subnet_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDbSubnetGroup.new(unexpected: 9) }
  end

  def test_subnet_non_existing
    refute AwsDbSubnetGroup.new(db_subnet_group_name: 'subnet-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsDbSubnetGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_subnet_groups
    mock_subnet = {}
    mock_subnet[:db_subnet_group_name] = 'default'
    mock_subnet[:db_subnet_group_description] = 'default'
    mock_subnet[:vpc_id] = 'vpc-12345678'
    mock_subnet[:subnet_group_status] = 'Complete'
    mock_subnet[:subnets] = [{ subnet_identifier: "subnet-12345678", \
                               subnet_availability_zone: { name: 'eu-west-1' }, \
                               subnet_status: "Active" }]
    mock_subnet[:db_subnet_group_arn] = "arn:aws:rds:string:subgrp:default"
    data[:data] = { db_subnet_groups: [mock_subnet] }
    data[:client] = Aws::RDS::Client
    @subnet_group = AwsDbSubnetGroup.new(db_subnet_group_name: 'default', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subnet_group_exists
    assert @subnet_group.exists?
  end

  def test_db_subnet_group_name 
    assert_equal(@subnet_group.db_subnet_group_name, 'default')
  end

  def test_db_subnet_group_description
    assert_equal(@subnet_group.db_subnet_group_description, 'default')
  end

  def test_vpc_id
    assert_equal(@subnet_group.vpc_id, 'vpc-12345678')
  end

  def test_subnet_group_status
    assert_equal(@subnet_group.subnet_group_status, 'Complete')
  end

  def test_db_subnet_group_arn
    assert_equal(@subnet_group.db_subnet_group_arn, 'arn:aws:rds:string:subgrp:default')
  end
end