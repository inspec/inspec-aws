require 'helper'
require 'aws_network_manager_devices'
require 'aws-sdk-core'

class AWSNetworkManagerDevicesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSNetworkManagerDevices.new(client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSNetworkManagerDevices.new('rubbish') }
  end

  def test_devices_non_existing_for_empty_response
    refute AWSNetworkManagerDevices.new(global_network_id: 'test1' , client_args: { stub_responses: true }).exist?
  end
end

class AWSNetworkManagerDevicesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_devices
    mock_data = {}
    mock_data[:device_id] = 'test1'
    mock_data[:device_arn] = 'test1'
    mock_data[:global_network_id] = 'test1'
    mock_data[:aws_location] = {
      zone: 'test1',
      subnet_arn: 'test1'
    }
    mock_data[:description] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:vendor] = 'test1'
    mock_data[:model] = 'test1'
    mock_data[:serial_number] = 'test1'
    mock_data[:location] = {
      address: 'test1',
      latitude: 'test1',
      longitude: 'test1'
    }
    mock_data[:site_id] = 'test1'
    mock_data[:created_at] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:state] = 'test1'
    data[:data] = { :devices => [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerDevices.new(global_network_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_device_ids
    assert_equal(@resp.device_ids, ['test1'])
  end

  def test_device_arns
    assert_equal(@resp.device_arns, ['test1'])
  end

  def test_global_network_ids
    assert_equal(@resp.global_network_ids, ['test1'])
  end

  def test_aws_location_zones
    assert_equal(@resp.location_zones, ['test1'])
  end

  def test_aws_location_subnet_arns
    assert_equal(@resp.location_subnet_arns, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_types
    assert_equal(@resp.types, ['test1'])
  end

  def test_vendors
    assert_equal(@resp.vendors, ['test1'])
  end

  def test_models
    assert_equal(@resp.models, ['test1'])
  end

  def test_serial_numbers
    assert_equal(@resp.serial_numbers, ['test1'])
  end

  def test_addresses
    assert_equal(@resp.addresses, ['test1'])
  end

  def test_latitudes
    assert_equal(@resp.latitudes, ['test1'])
  end

  def test_longitudes
    assert_equal(@resp.longitudes, ['test1'])
  end

  def test_site_ids
    assert_equal(@resp.site_ids, ['test1'])
  end

  def test_created_at
    assert_equal(@resp.created_at, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end
end