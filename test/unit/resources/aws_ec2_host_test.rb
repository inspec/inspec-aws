require 'helper'
require 'aws_ec2_host'
require 'aws-sdk-core'

class AWSEC2HostConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2Host.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2Host.new(host_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2Host.new(unexpected: 9) }
  end
end

class AWSEC2HostSuccessPathTest < Minitest::Test

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
    data[:data] = { hosts: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2Host.new(host_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_hosts_exists
    assert @resp.exists?
  end

  def test_auto_placement
    assert_equal(@resp.auto_placement, 'test1')
  end

  def test_availability_zone
    assert_equal(@resp.availability_zone, 'test1')
  end

  def test_available_capacity
    assert_equal(@resp.available_capacity, {})
  end

  def test_client_token
    assert_equal(@resp.client_token, 'test1')
  end

  def test_host_id
    assert_equal(@resp.host_id, 'test1')
  end

  def test_host_properties
    assert_equal(@resp.host_properties, {})
  end

  def test_host_reservation_id
    assert_equal(@resp.host_reservation_id, 'test1')
  end

  def test_instances
    assert_equal(@resp.instances, [])
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end

  def test_host_recovery
    assert_equal(@resp.host_recovery, 'test1')
  end

  def test_allows_multiple_instance_types
    assert_equal(@resp.allows_multiple_instance_types, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_availability_zone_id
    assert_equal(@resp.availability_zone_id, 'test1')
  end

  def test_member_of_service_linked_resource_group
    assert_equal(@resp.member_of_service_linked_resource_group, true)
  end
end
