require 'aws_backend'

class AwsEc2TransitGatewayAttachment < AwsResourceBase
  name 'aws_ec2_transit_gateway_attachement'
  desc 'Describes one or more attachments between resources and transit gateways. By default, all attachments are described. Alternatively, you can filter the results by attachment ID, attachment state, resource ID, or resource owner.'

  def initialize(opts = {})
    opts = { transit_gateway_attachment_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_attachment_id])

    raise ArgumentError, "#{@__resource_name__}: transit_gateway_attachment_id must be provided" unless opts[:transit_gateway_attachment_id] && !opts[:transit_gateway_attachment_id].empty?
    @display_name = opts[:transit_gateway_attachment_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateway_attachments({ transit_gateway_attachment_ids: [opts[:transit_gateway_attachment_id]] })
      @transit_gateway_attachments = resp.transit_gateway_attachments[0].to_h
      create_resource_methods(@transit_gateway_attachments)
    end
  end

  def id
    return nil unless exists?
    @transit_gateway_attachments[:transit_gateway_attachment_id]
  end

  def exists?
    !@transit_gateway_attachments.nil? && !@transit_gateway_attachments.empty?
  end

  def encrypted?
    @transit_gateway_attachments[:encrypted]
  end

  def to_s
    "Transit gateway attachment #{@display_name}"
  end
end
