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

  def test_iam_client_non_existing_for_empty_response
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
    @iam_client = AWSIAMVirtualMFADevices.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_iam_client_exists
    assert @iam_client.exist?
  end

  def test_paths
    assert_equal(@iam_client.path, ['/'])
  end

  def test_instance_user_id
    assert_equal(@iam_client.user_ids, ['test1'])
  end

  def test_instance_serial_number
    assert_equal(@iam_client.serial_number, ['test1'])
  end

  def test_arns
    assert_equal(@iam_client.arns, ['test1'])
  end
end
