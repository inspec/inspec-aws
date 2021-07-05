require_relative 'aws_base_resource_mock'

class AwsVPNGatewayMock < AwsBaseResourceMock
  attr_reader :availability_zone, :state, :type, :vpc_attachments, :vpn_gateway_id, :amazon_side_asn, :tags, :vpc_id

  def initialize
    super
    @availability_zone = 'us-east-1a'
    @state = 'available'
    @type = 'ipsec.1'
    @vpc_id = 'vpc-0a123456776210f2f'
    @vpc_attachments = [{ state: 'attached', vpc_id: vpc_id }]
    @vpn_gateway_id = 'vgw-014a123456789abcde'
    @amazon_side_asn = 64512
    @tags = [{ key: 'Name', value: 'my-vpn' }]
    @vpn_gateway = {
      vpn_gateways: [{
        availability_zone: availability_zone,
        state: state,
        type: type,
        vpc_attachments: vpc_attachments,
        vpn_gateway_id: vpn_gateway_id,
        amazon_side_asn: amazon_side_asn,
        tags: tags,
      }],
    }
  end

  def stub_data
    {
      method: :describe_vpn_gateways,
      data: @vpn_gateway,
      client: Aws::EC2::Client,
    }
  end

  def multiple_stub_data(num = 2)
    {
      method: :describe_vpn_gateways,
      data: vpn_gateways_collection(num),
      client: Aws::EC2::Client,
    }
  end

  def vpn_gateways_collection(num)
    num.times.map { @vpn_gateway }
  end
end
