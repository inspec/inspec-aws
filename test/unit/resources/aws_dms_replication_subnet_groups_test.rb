require 'helper'
require 'aws_dms_replication_subnet_groups'
require 'aws-sdk-core'

class AWSDMSReplicationSubnetGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSDMSReplicationSubnetGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSDMSReplicationSubnetGroups.new('rubbish') }
  end

  def test_replication_subnet_groups_non_existing_for_empty_response
    refute AWSDMSReplicationSubnetGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSDMSReplicationSubnetGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_replication_subnet_groups
    mock_parameter = {}
    mock_parameter[:replication_subnet_group_identifier] = 'test1'
    mock_parameter[:replication_subnet_group_description] = 'test1'
    mock_parameter[:vpc_id] = 'test1'
    mock_parameter[:subnet_group_status] = 'test1'
    data[:data] = { :replication_subnet_groups => [mock_parameter] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @replication_subnet_groups = AWSDMSReplicationSubnetGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_replication_subnet_groups_exists
    assert @replication_subnet_groups.exist?
  end

  def test_replication_subnet_group_identifiers
    assert_equal(@replication_subnet_groups.replication_subnet_group_identifiers, ['test1'])
  end

  def test_replication_subnet_group_descriptions
    assert_equal(@replication_subnet_groups.replication_subnet_group_descriptions, ['test1'])
  end

  def test_vpc_ids
    assert_equal(@replication_subnet_groups.vpc_ids, ['test1'])
  end

  def test_subnet_group_statuses
    assert_equal(@replication_subnet_groups.subnet_group_statuses, ['test1'])
  end
end