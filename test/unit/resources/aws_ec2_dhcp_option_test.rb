require 'helper'
require 'aws_ec2_dhcp_option'
require 'aws-sdk-core'

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

  def test_raises_invalid_ec2_id
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-not-allowed') }
  end

  def test_raises_empty_name
    assert_raises(ArgumentError) { AwsEc2DHCPOption.new(dhcp_options_id: '') }
  end

  def test_dopt_non_existing
    refute AwsEc2DHCPOption.new(dhcp_options_id: 'dopt-1234abcd', client_args: { stub_responses: true }).exists?
  end
end
