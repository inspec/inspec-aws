require 'helper'
require 'aws_dhcp_options'
require 'aws-sdk-core'

class AwsDhcpOptionsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDhcpOptions.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsDhcpOptions.new('rubbish') }
  end

  def test_accepts_dopt_as_hash_eight_sign
    AwsDhcpOptions.new(dhcp_options_id: 'dopt-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_dopt_id_as_hash
    AwsDhcpOptions.new(dhcp_options_id: 'dopt-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDhcpOptions.new(rubbish: 99) }
  end

  def test_rejects_invalid_ec2_id
    assert_raises(ArgumentError) { AwsDhcpOptions.new(dhcp_options_id: 'dopt-not-allowed') }
  end

  def test_rejects_empty_name
    assert_raises(ArgumentError) { AwsDhcpOptions.new(dhcp_options_id: '') }
  end

  def test_dopt_non_existing
    refute AwsDhcpOptions.new(dhcp_options_id: 'dopt-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsDhcpOptionsConstructorIdTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_dhcp_options
    data[:data] = {
      :dhcp_options => [
        {
          :dhcp_configurations => [
            {
              :key => 'domain-name-servers',
              :values => [
                {
                  :value => 'AmazonProvidedDNS'
                }
              ]
            },
            {
              :key => 'ntp-servers',
              :values => [
                {
                  :value => '169.254.169.123'
                }
              ]
            }
          ],
          :dhcp_options_id => 'dopt-00b5186ddefdb50bf',
          :tags => [
            {
              :key => 'Name',
              :value => 'aws-inspec-dopt'
            }
          ]
        }
      ]
    }
    data[:client] = Aws::EC2::Client
    @dopt = AwsDhcpOptions.new(dhcp_options_id: 'dopt-00b5186ddefdb50bf', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_dhcp_options_id
    assert_equal(@dopt.dhcp_options_id, 'dopt-00b5186ddefdb50bf')
  end

  def test_ec2_exists
    assert @dopt.exists?
  end

  def test_dhcp_domain_name_servers
    assert_equal(@dopt.domain_name_servers, ['AmazonProvidedDNS'])
  end

  def test_dhcp_ntp_servers
    assert_equal(@dopt.ntp_servers, ['169.254.169.123'])
  end
end
