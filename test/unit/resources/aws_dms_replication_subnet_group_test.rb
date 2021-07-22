require 'helper'
require 'aws_dms_replication_subnet_group'
require 'aws-sdk-core'

class AWSDMSReplicationSubnetGroupConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSDMSReplicationSubnetGroup.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_volume_id_as_hash_eight_sign
    AWSDMSReplicationSubnetGroup.new(replication_subnet_group_identifier: 'test1', client_args: { stub_responses: true })
  end

  def test_accepts_volume_id_as_hash
    AWSDMSReplicationSubnetGroup.new(replication_subnet_group_identifier: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSDMSReplicationSubnetGroup.new(rubbish: 9) }
  end

  def test_endpoints_non_existing
    refute AWSDMSReplicationSubnetGroup.new(replication_subnet_group_identifier: 'test1', client_args: { stub_responses: true }).exists?
  end

  def test_endpoints_non_existing_name
    refute AWSDMSReplicationSubnetGroup.new(replication_subnet_group_identifier: 'not-there', client_args: { stub_responses: true }).exists?
  end
end

class AWSDMSReplicationSubnetGroupHappyPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_replication_subnet_groups
    mock_data = {}
    mock_data[:replication_subnet_group_identifier] = 'test1'
    mock_data[:replication_subnet_group_description] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:subnet_group_status] = 'test1'
    data[:data] = { replication_subnet_groups: [mock_data] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @replication_subnet_groups = AWSDMSReplicationSubnetGroup.new(replication_subnet_group_identifier: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_replication_subnet_groups_exists
    assert @replication_subnet_groups.exists?
  end

  def test_replication_subnet_group_identifier
    assert_equal(@replication_subnet_groups.replication_subnet_group_identifier, 'test1')
  end

  def testreplication_subnet_group_description
    assert_equal(@replication_subnet_groups.replication_subnet_group_description, 'test1')
  end

  def test_vpc_id
    assert_equal(@replication_subnet_groups.vpc_id, 'test1')
  end

  def test_subnet_group_status
    assert_equal(@replication_subnet_groups.subnet_group_status, 'test1')
  end
end
