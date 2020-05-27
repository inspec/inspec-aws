require_relative 'aws_base_resource_mock'

class AwsNatGatewayMock < AwsBaseResourceMock
  def multiple(n)
    # Create data for multiple resources
    mocks = []
    n.times do
      mocks << {
          create_time: Time.parse(@aws.any_date.to_s),
          nat_gateway_addresses: [
              {
                  allocation_id: "eipalloc-#{@aws.any_hex}",
                  network_interface_id: "eni-#{@aws.any_hex}",
                  private_ip: "10.0.1.68",
                  public_ip: "154.149.206.40"
              }
          ],
          nat_gateway_id: "nat-#{@aws.any_hex}",
          state: "available",
          subnet_id: "subnet-#{@aws.any_hex}",
          vpc_id: "vpc-#{@aws.any_hex}",
          tags: [
              {
                  key: "Name",
                  value: "aws-nat-gateway-#{@aws.any_string}"
              }
          ]
      }
    end
    mocks.freeze
  end
end
