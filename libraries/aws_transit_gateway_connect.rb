# frozen_string_literal: true

require 'aws_backend'

class AWSTransitGatewayConnect < AwsResourceBase
  name 'aws_transit_gateway_connect'
  desc 'Describes one or more Connect attachments.'

  example "
    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'test') do
      it { should eq 'test' }
    end

    describe aws_transit_gateway_connect(transit_gateway_attachment_ids: 'test') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_attachment_ids: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_attachment_ids])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_attachment_ids must be provided" unless opts[:transit_gateway_attachment_ids] && !opts[:transit_gateway_attachment_ids].empty?
    @display_name = opts[:transit_gateway_attachment_ids]
    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateway_connects({ transit_gateway_attachment_ids: [opts[:transit_gateway_attachment_ids]] })
      @transit_gateway_connects = resp.transit_gateway_connects[0].to_h
      create_resource_methods(@transit_gateway_connects)
    end
  end

  def transit_gateway_attachment_id
    return nil unless exists?
    @transit_gateway_connects[:transit_gateway_attachment_ids]
  end

  def exists?
    !@transit_gateway_connects.nil? && !@transit_gateway_connects.empty?
  end

  def to_s
    "Transit Gateway Attachment ID: #{@display_name}"
  end
end
