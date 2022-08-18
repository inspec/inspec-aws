require_relative 'aws_base_resource_mock'

class AwsVPNConnectionMock < AwsBaseResourceMock
  
  attr_reader :customer_gateway_configuration, :customer_gateway_id, :category,
              :state, :type, :vpc_attachments, :vpn_gateway_id, :tags, :vpn_connection_id,
              :transit_gateway_id, :core_network_arn, :core_network_attachment_arn, :gateway_association_state

  def initialize
    super
    @customer_gateway_configuration = 'test_customer_gateway_configuration'
    @customer_gateway_id = 'test_customer_gateway_id'
    @category = 'test_category'
    @state = 'available'
    @type = 'ipsec.1'
    @vpn_connection_id = 'vpn-014a12345'
    @vpn_gateway_id = 'vgw-014a123456789abcde'
    @transit_gateway_id = 'test_transit_gateway_id'
    @core_network_arn = 'test_core_network_arn'
    @core_network_attachment_arn = 'test_core_network_attachment_arn'
    @gateway_association_state = 'associated'
    @tags = [{ key: 'Name', value: 'my-vpn' }]
    
    @vpn_connection = {
      vpn_connections: [{
                          customer_gateway_configuration: customer_gateway_configuration,
                          customer_gateway_id: customer_gateway_id,
                          category: category,
                          state: state,
                          type: type,
                          vpn_connection_id: vpn_connection_id,
                          vpn_gateway_id: vpn_gateway_id,
                          transit_gateway_id: transit_gateway_id,
                          core_network_arn: core_network_arn,
                          core_network_attachment_arn: core_network_attachment_arn,
                          gateway_association_state: gateway_association_state,
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
