require_relative 'aws_base_resource_mock'

class AwsInternetGatewayMock < AwsBaseResourceMock
  def multiple(n)
    # Create multiple Internet Gateways
    mocks = []
    n.times do
      mocks << {
          attachments: [
              {
                  state: "available",
                  vpc_id: "vpc-#{@aws.any_hex}"
              }
          ],
          internet_gateway_id: "igw-#{@aws.any_hex}",
          owner_id: "810337011854",
          tags: [
              {
                  key: "Name",
                  value: "#{@aws.any_string}"
              },
          ]
      }
    end
    mocks.freeze
  end
end
