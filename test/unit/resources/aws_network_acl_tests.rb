
require 'helper'
require 'aws_network_acl_tests'
require 'aws-sdk-core'
require_relative 'mock/aws_network_acl_mock'

class AwsNetworkACLsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsNetworkACLs.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsNetworkACLs.new('random') }
  end

  def test_instances_non_existing_for_empty_response
    refute AwsNetworkACLs.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsNetworkACLsConstructorIDTest < Minitest::Test
  def setup
    @mock_nw_acl = AwsNetworkACLMock.new

    @dhcp_options = AwsNetworkACLs.new(client_args: { stub_responses: true },
                                          stub_data: [@mock_nw_acl.multiple_stub_data])
  end

  def test_exists
    assert @dhcp_options.exist?
  end
end