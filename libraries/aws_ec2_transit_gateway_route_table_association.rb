# frozen_string_literal: true

require 'aws_backend'

class AwsEc2TransitGatewayRouteTableAssociation < AwsResourceBase
  name 'aws_ec2_transit_gateway_routetable_association'
  desc 'Gets information about the associations for the specified transit gateway route table.'

  example `
    describe aws_ec2_transit_gateway_routetable_association(transit_gateway_attachment_id: 'tgw-attach-0123456789') do
      it { should exist }
    end
  `

  attr_reader :table

  def initialize(opts = {})
    opts = { transit_gateway_attachment_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_attachment_id])

    raise ArgumentError, "#{@__resource_name__}: transit_gateway_attachment_id must be provided" unless opts[:transit_gateway_attachment_id] && !opts[:transit_gateway_attachment_id].empty?
    @display_name = opts[:aws_transit_gateway_attachment_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateway_attachments({ transit_gateway_attachment_ids: [opts[:transit_gateway_attachment_id]] })
      @transit_gateway_attachment = resp.transit_gateway_attachments[0].association.to_h
      create_resource_methods(@transit_gateway_attachment)
    end
  end

  def id
    return nil unless exists?
    @transit_gateway_attachment[:transit_gateway_attachment_id]
  end

  def exists?
    !@transit_gateway_attachment.nil? && !@transit_gateway_attachment.empty?
  end

  def encrypted?
    @transit_gateway_attachment[:encrypted]
  end

  def to_s
    "Transit gateway Route table Association #{@display_name}"
  end
end
