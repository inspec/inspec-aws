require 'helper'
require 'aws_ec2_network_interface_permissions'
require 'aws-sdk-core'

class AWSEC2NetworkInterfacePermissionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2NetworkInterfacePermissions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2NetworkInterfacePermissions.new(network_interface_permission_id: 'dummy,', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInterfacePermissions.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInterfacePermissionsSuccessPathTest < Minitest::Test

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
    @resp = AWSEC2NetworkInterfacePermissions.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_interfaces_permissions_exists
    assert @resp.exists?
  end

  def test_network_interface_ids
    assert_equal(@resp.network_interface_permission_ids, ['test1'])
  end

  def test_aws_account_ids
    assert_equal(@resp.aws_account_ids, ['test1'])
  end

  def test_aws_services
    assert_equal(@resp.aws_services, ['test1'])
  end

end