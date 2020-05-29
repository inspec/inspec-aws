require 'helper'
require 'aws_db_subnet_groups'
require 'aws-sdk-core'

class AwsDbSubnetGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsDbSubnetGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsDbSubnetGroups.new('rubbish') }
  end

  def test_subnets_non_existing_for_empty_response
    refute AwsDbSubnetGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsDbSubnetGroupsSuccessPathTest < Minitest::Test

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
    @subnet_groups = AwsDbSubnetGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subnet_groups_exist
    assert @subnet_groups.exist?
  end

  def test_db_subnet_group_name 
    assert_equal(@subnet_groups.db_subnet_group_names, ['default'])
  end

  def test_db_subnet_group_description
    assert_equal(@subnet_groups.db_subnet_group_descriptions, ['default'])
  end

  def test_vpc_id
    assert_equal(@subnet_groups.vpc_ids, ['vpc-12345678'])
  end

  def test_subnet_group_status
    assert_equal(@subnet_groups.subnet_group_status, ['Complete'])
  end

  def test_subnet
    assert_equal(@subnet_groups.subnets.dig(0, 0, :subnet_identifier), 'subnet-12345678')
  end

  def test_db_subnet_group_arn
    assert_equal(@subnet_groups.db_subnet_group_arns, ['arn:aws:rds:string:subgrp:default'])
  end
end