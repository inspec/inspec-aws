require "aws_backend"

class AWSEC2CarrierGateway < AwsResourceBase
  name "aws_ec2_carrier_gateway"
  desc "Describes single carrier gateway."
  example <<-EXAMPLE
    describe aws_ec2_carrier_gateway(carrier_gateway_id: 'CARRIER_GATEWAY_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { carrier_gateway_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:carrier_gateway_id])
    unless opts[:carrier_gateway_id] && !opts[:carrier_gateway_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: carrier_gateway_id must be provided"
    end
    @display_name = opts[:carrier_gateway_id]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_carrier_gateways(
          { carrier_gateway_ids: [opts[:carrier_gateway_id]] }
        )
      @resp = resp.carrier_gateways[0].to_h
      @carrier_gateway_id = resp.carrier_gateways[0].carrier_gateway_id
      create_resource_methods(@resp)
    end
  end

  def carrier_gateway_id
    return nil unless exists?
    @resp[:carrier_gateway_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @carrier_gateway_id
  end

  def to_s
    "Carrier Gateway Id: #{@display_name}"
  end
end
