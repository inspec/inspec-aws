require 'helper'
require 'aws_ec2_hosts'
require 'aws-sdk-core'

class AWSEC2HostsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2Hosts.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2Hosts.new('rubbish') }
  end

  def test_hosts_non_existing_for_empty_response
    refute AWSEC2Hosts.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2HostsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_hosts
    mock_data = {}
    mock_data[:auto_placement] = 'test1'
    mock_data[:availability_zone] = 'test1'
    mock_data[:available_capacity] = {}
    mock_data[:client_token] = 'test1'
    mock_data[:host_id] = 'test1'
    mock_data[:host_properties] = {}
    mock_data[:host_reservation_id] = 'test1'
    mock_data[:instances] = []
    mock_data[:state] = 'test1'
    mock_data[:allocation_time] = Time.now
    mock_data[:release_time] = Time.now
    mock_data[:tags] = []
    mock_data[:host_recovery] = 'test1'
    mock_data[:allows_multiple_instance_types] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:availability_zone_id] = 'test1'
    mock_data[:member_of_service_linked_resource_group] = true
    data[:data] = { :hosts => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2Hosts.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_auto_placements
    assert_equal(@resp.auto_placements, ['test1'])
  end

  def test_availability_zones
    assert_equal(@resp.availability_zones, ['test1'])
  end

  def test_client_tokens
    assert_equal(@resp.client_tokens, ['test1'])
  end

  def test_host_ids
    assert_equal(@resp.host_ids, ['test1'])
  end

  def test_instances
    assert_equal(@resp.instances, [[]])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end

  def test_host_recoveries
    assert_equal(@resp.host_recoveries, ['test1'])
  end

  def test_allows_multiple_instance_types
    assert_equal(@resp.allows_multiple_instance_types, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_availability_zone_ids
    assert_equal(@resp.availability_zone_ids, ['test1'])
  end

  def test_member_of_service_linked_resource_groups
    assert_equal(@resp.member_of_service_linked_resource_groups, [true])
  end
end
