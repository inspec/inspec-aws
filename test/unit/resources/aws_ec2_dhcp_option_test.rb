require 'helper'
require 'aws_ec2_dhcp_option'
require 'aws-sdk-core'
require_relative 'mock/aws_ec2_dhcp_option_mock'

class AwsEc2DHCPOptionConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(client_args: { stub_responses: true }) }
  end

  def test_raises_invalid_dhcp_option_id
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new('not-dopt') }
  end

  def test_accepts_dopt_as_hash_eight_sign
    AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_dopt_id_as_hash
    AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_raises_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(random: 99) }
  end

  def test_raises_invalid_dhcp_id
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-not-allowed') }
  end

  def test_raises_empty_name
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(dhcp_options_id: '') }
  end

  def test_dopt_non_existing
    refute AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsEc2DHCPOptionConstructorIdTest < Minitest::Test
  def setup
    @dhcp_mock = AwsEc2DHCPOptionMock.new
    @dhcp = AwsEc2DHCPOption.new(dhcp_options_id: @dhcp_mock.dhcp_options_id,
                                 client_args: { stub_responses: true },
                                 stub_data: [@dhcp_mock.stub_data])
  end

  def test_dhcp_options_id
    assert_equal(@dhcp.dhcp_options_id, @dhcp_mock.dhcp_options_id)
  end

  def test_ec2_exists
    assert @dhcp.exists?
  end

  def test_dhcp_domain_name_servers
    assert_equal(@dhcp.domain_name_servers, [@dhcp_mock.domain_name_server])
  end

  def test_dhcp_ntp_servers
    assert_equal(@dhcp.ntp_servers, [@dhcp_mock.ntp_server])
  end

  def test_netbios_name_servers
    assert_equal(@dhcp.netbios_name_servers, [@dhcp_mock.netbios_name_server])
  end

  def test_netbios_node_type
    assert_equal(@dhcp.netbios_node_type, @dhcp_mock.netbios_node_type.to_i)
  end

  def test_domain_name
    assert_equal(@dhcp.domain_name, @dhcp_mock.domain_name)
  end
end
