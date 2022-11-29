require 'aws_backend'

class AWSEC2InternetGateway < AwsResourceBase
  name 'aws_ec2_internet_gateway'
  desc 'Describes a ec2 internet gateway.'

  example "
    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { internet_gateway_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:internet_gateway_id])
    raise ArgumentError, "#{@__resource_name__}: internet_gateway_id must be provided" unless opts[:internet_gateway_id] && !opts[:internet_gateway_id].empty?
    @display_name = opts[:internet_gateway_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_internet_gateways({ internet_gateway_ids: [opts[:internet_gateway_id]] })
      @res = resp.internet_gateways[0].to_h
      create_resource_methods(@res)
    end
  end

  def internet_gateway_id
    return nil unless exists?
    @res[:internet_gateway_id]
  end

  def attachments_states
    attachments.map(&:state)
  end

  def attachments_vpc_ids
    attachments.map(&:vpc_id)
  end

  def resource_id
    @res ? @res[:internet_gateway_id] : @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Internet Gateway ID: #{@display_name}"
  end
end
