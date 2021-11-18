require 'helper'
require 'aws_ec2_network_interface_permission'
require 'aws-sdk-core'

class AWSEC2NetworkInterfacePermissionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterfacePermission.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterfacePermission.new(network_interface_permission_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInterfacePermission.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInterfacePermissionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_interface_permissions
    mock_data = {}
    mock_data[:network_interface_permission_id] = 'test1'
    mock_data[:aws_account_id] = 'test1'
    mock_data[:aws_service] = 'test1'
    mock_data[:permission_state] = {
      state: "pending",
      status_message: "test1",
    }
    data[:data] = { network_interface_permissions: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterfacePermission.new(network_interface_permission_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_interfaces_permission_exists
    assert @resp.exists?
  end

  def test_network_interface_id
    assert_equal(@resp.network_interface_permission_id, 'test1')
  end

  def test_aws_account_id
    assert_equal(@resp.aws_account_id, 'test1')
  end

  def test_aws_service
    assert_equal(@resp.aws_service, 'test1')
  end
end