require_relative 'aws_base_resource_mock'

class AwsEc2DHCPOptionMock < AwsBaseResourceMock
  attr_reader :dhcp_options_id, :domain_name_server, :ntp_server, :netbios_node_type, :domain_name, :netbios_name_server

  def initialize
    super
    @dhcp_options_id = 'dopt-00b5186ddefdb50bf'
    @domain_name_server = 'AmazonProvidedDNS'
    @ntp_server = '169.254.169.123'
    @netbios_node_type = '2'
    @domain_name = 'compliance.chef.com'
    @netbios_name_server = '192.168.0.4'
    @dhcp_option = {
      dhcp_options: [
        {
          dhcp_configurations: [
            {
              key: 'domain-name-servers',
              values: [{ value: domain_name_server }],
            },
            {
              key: 'ntp-servers',
              values: [{ value: ntp_server }],
            },
            {
              key: 'netbios-node-type',
              values: [{ value: netbios_node_type }],
            },
            {
              key: 'domain-name',
              values: [{ value: domain_name }],
            },
            {
              key: 'netbios-name-servers',
              values: [{ value: netbios_name_server }],
            },
          ],
          dhcp_options_id: dhcp_options_id,
          tags: [
            {
              key: 'Name',
              value: 'aws-inspec-dopt',
            },
          ],
        },
      ],
    }
  end

  def stub_data
    {}.tap do |hash|
      hash[:method] = :describe_dhcp_options
      hash[:data] = @dhcp_option
      hash[:client] = Aws::EC2::Client
    end
  end

  def multiple_stub_data(num = 2)
    {}.tap do |hash|
      hash[:method] = :describe_dhcp_options
      hash[:data] = dhcp_option_collection(num)
      hash[:client] = Aws::EC2::Client
    end
  end

  def dhcp_option_collection(num)
    num.times.map { @dhcp_option }
  end
end
