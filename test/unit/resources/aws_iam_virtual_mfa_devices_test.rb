require 'helper'
require 'aws_iam_virtual_mfa_devices'
require 'aws-sdk-core'

class AWSIAMVirtualMFADevicesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSIAMVirtualMFADevices.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSIAMVirtualMFADevices.new('rubbish') }
  end

  def test_iam_virtual_mfa_devices_non_existing_for_empty_response
    refute AWSIAMVirtualMFADevices.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSIAMVirtualMFADevicesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_virtual_mfa_devices
    mock_data = {}
    user= {}
    user[:path] = '/'
    mock_data[:serial_number]= "test1"
    user[:user_id] = 'test1'
    user[:user_name] = 'test1'
    user[:arn] = 'test1'
    mock_data[:user] = user
    user[:create_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :virtual_mfa_devices => [mock_data] }
    data[:client] = Aws::IAM::Client
    @resp = AWSIAMVirtualMFADevices.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_virtual_mfa_devices_exists
    assert @resp.exist?
  end

  def test_paths
    assert_equal(@resp.paths, ['/'])
  end

  def test_user_ids
    assert_equal(@resp.user_ids, ['test1'])
  end

  def test_serial_numbers
    assert_equal(@resp.serial_numbers, ['test1'])
  end

  def test_arns
    assert_equal(@resp.arns, ['test1'])
  end
end
