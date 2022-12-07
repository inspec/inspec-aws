require 'aws_backend'

class AWSEC2CustomerGateway < AwsResourceBase
  name 'aws_ec2_customer_gateway'
  desc 'Describes one VPN customer gateways.'

  example "
    describe aws_ec2_customer_gateway(customer_gateway_id: 'CUSTOMER_GATEWAY_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { customer_gateway_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:customer_gateway_id])
    raise ArgumentError, "#{@__resource_name__}: customer_gateway_id must be provided" unless opts[:customer_gateway_id] && !opts[:customer_gateway_id].empty?
    @display_name = opts[:customer_gateway_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_customer_gateways({ customer_gateway_ids: [opts[:customer_gateway_id]] })
      @resp = resp.customer_gateways[0].to_h
      create_resource_methods(@resp)
    end
  end

  def customer_gateway_id
    return nil unless exists?
    @resp[:customer_gateway_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @resp ? @resp[:customer_gateway_id] : @display_name
  end

  def to_s
    "Customer Gateway Id: #{@display_name}"
  end
end
