require 'helper'
require 'aws_network_acl_test'
require 'aws-sdk-core'
require_relative 'mock/aws_network_acl_mock'

class AwsNetworkACLConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsNetworkACL.new(client_args: { stub_responses: true }) }
  end

  def test_raises_invalid_network_acl
    assert_raises(ArgumentError) { AwsNetworkACL.new('not-1234') }
  end

  def test_accepts_acl_id_as_hash
    AwsNetworkACL.new(network_acl_id: 'acl-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_raises_unrecognized_params
    assert_raises(ArgumentError) { AwsNetworkACL.new(random: 99) }
  end

  def test_raises_invalid_dhcp_id
    assert_raises(ArgumentError) { AwsNetworkACL.new(network_acl_id: 'acl-not-allowed') }
  end

  def test_raises_empty_name
    assert_raises(ArgumentError) { AwsNetworkACL.new(network_acl_id: '') }
  end

  def test_acl_non_existing
    refute AwsNetworkACL.new(network_acl_id: 'acl-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsNetworkACLConstructorIdTest < Minitest::Test
  def setup
    @network_acl_mock = AwsNetworkACLMock.new
    @network_acl = AwsNetworkACL.new(network_acl_id: @network_acl_mock.network_acl_id,
                                 client_args: { stub_responses: true },
                                 stub_data: [@network_acl_mock.stub_data])
  end

  def test_network_acl_id
    assert_equal(@network_acl_mock.network_acl_id, @network_acl_mock.network_acl_id)
  end

end
