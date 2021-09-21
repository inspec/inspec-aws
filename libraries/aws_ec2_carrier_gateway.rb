# frozen_string_literal: true

require 'aws_backend'

class AWSEC2CarrierGateway < AwsResourceBase
  name 'aws_ec2_carrier_gateway'
  desc 'Describes one or more of your carrier gateways.'

  example "
    describe aws_ec2_capacity_reservation(carrier_gateway_id: 'CarrierGatewayId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { carrier_gateway_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:carrier_gateway_id])
    raise ArgumentError, "#{@__resource_name__}: capacity_reservation_id must be provided" unless opts[:carrier_gateway_id] && !opts[:carrier_gateway_id].empty?
    @display_name = opts[:carrier_gateway_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_carrier_gateways({ carrier_gateway_ids: [opts[:carrier_gateway_id]] })
      @resp = resp.carrier_gateways[0].to_h
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

  def to_s
    "Capacity Gateway Id: #{@display_name}"
  end
end