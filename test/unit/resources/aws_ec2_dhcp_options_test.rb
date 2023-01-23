require 'helper'
require 'aws_ec2_dhcp_options'
require 'aws-sdk-core'
require_relative 'mock/aws_ec2_dhcp_option_mock'

class AwsEc2DHCPOptionsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsEc2DHCPOptions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEc2DHCPOptions.new('random') }
  end

  def test_dhcp_options_non_existing_for_empty_response
    refute AwsEc2DHCPOptions.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEc2DHCPOptionsConstructorIDTest < Minitest::Test
  def setup
    @dhcp_options_mock = AwsEc2DHCPOptionMock.new

    @dhcp_options = AwsEc2DHCPOptions.new(client_args: { stub_responses: true },
                                         stub_data: [@dhcp_options_mock.multiple_stub_data])
  end

  def test_exists
    assert @dhcp_options.exist?
  end

  def test_domain_name
    assert_equal(@dhcp_options.domain_names, [@dhcp_options_mock.domain_name])
  end

  def test_domain_name_servers
    assert_equal(@dhcp_options.domain_name_servers, [@dhcp_options_mock.domain_name_server])
  end

  def test_ntp_servers
    assert_equal(@dhcp_options.ntp_servers, [@dhcp_options_mock.ntp_server])
  end

  def test_netbios_node_types
    assert_equal(@dhcp_options.netbios_node_types, [@dhcp_options_mock.netbios_node_type.to_i])
  end

  def test_netbios_name_server
    assert_equal(@dhcp_options.netbios_name_servers, [@dhcp_options_mock.netbios_name_server])
  end
end
