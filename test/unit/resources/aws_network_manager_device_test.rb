require 'helper'
require 'aws_network_manager_device'
require 'aws-sdk-core'

class AWSNetworkManagerDeviceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerDevice.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSNetworkManagerDevice.new(global_network_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSNetworkManagerDevice.new(unexpected: 9) }
  end
end

class AWSNetworkManagerDeviceSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_devices
    mock_data = {}
    mock_data[:device_id] = 'test1'
    mock_data[:device_arn] = 'test1'
    mock_data[:global_network_id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:vendor] = 'test1'
    mock_data[:model] = 'test1'
    mock_data[:serial_number] = 'test1'
    mock_data[:site_id] = 'test1'
    mock_data[:created_at] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:state] = 'test1'
    data[:data] = { devices: [mock_data] }
    data[:client] = Aws::NetworkManager::Client
    @resp = AWSNetworkManagerDevice.new(global_network_id: 'test1', device_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_devices_exists
    assert @resp.exists?
  end

  def test_device_id
    assert_equal(@resp.device_id, 'test1')
  end

  def test_device_arn
    assert_equal(@resp.device_arn, 'test1')
  end

  def test_global_network_id
    assert_equal(@resp.global_network_id, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_type
    assert_equal(@resp.type, 'test1')
  end

  def test_vendor
    assert_equal(@resp.vendor, 'test1')
  end

  def test_model
    assert_equal(@resp.model, 'test1')
  end

  def test_serial_number
    assert_equal(@resp.serial_number, 'test1')
  end

  def test_site_id
    assert_equal(@resp.site_id, 'test1')
  end

  def test_created_at
    assert_equal(@resp.created_at, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end
end