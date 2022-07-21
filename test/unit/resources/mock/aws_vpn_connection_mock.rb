require_relative 'aws_base_resource_mock'

class AwsVPNConnectionMock < AwsBaseResourceMock
  attr_reader :state, :type, :vpc_attachments, :vpn_gateway_id, :tags, :vpn_connection_id

  def initialize
    super
    @state = 'available'
    @type = 'ipsec.1'
    @vpn_connection_id = 'vc-014a12345'
    @vpn_gateway_id = 'vgw-014a123456789abcde'
    @tags = [{ key: 'Name', value: 'my-vpn' }]
    @vpn_connection = {
      vpn_connections: [{
        state: state,
        type: type,
        vpn_connection_id: vpn_connection_id,
        tags: tags,
      }],
    }
  end

  def stub_data
    {
      method: :describe_vpn_connections,
      data: @vpn_connection,
      client: Aws::EC2::Client,
    }
  end

  def multiple_stub_data(num = 2)
    {
      method: :describe_vpn_connections,
      data: vpn_connections_collection(num),
      client: Aws::EC2::Client,
    }
  end

  def vpn_connections_collection(num)
    num.times.map { @vpn_connection }
  end
end