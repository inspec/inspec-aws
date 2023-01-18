require "aws_backend"

class AWSEC2VPCPeeringConnection < AwsResourceBase
  name "aws_ec2_vpc_peering_connection"
  desc "Describes a vpc peering connection."

  example "
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { vpc_peering_connection_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpc_peering_connection_id])
    raise ArgumentError, "#{@__resource_name__}: vpc_peering_connection_id must be provided" unless opts[:vpc_peering_connection_id] && !opts[:vpc_peering_connection_id].empty?
    @display_name = opts[:vpc_peering_connection_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_vpc_peering_connections({ vpc_peering_connection_ids: [opts[:vpc_peering_connection_id]] })
      @res = resp.vpc_peering_connections[0].to_h
      create_resource_methods(@res)
    end
  end

  def vpc_peering_connection_id
    return nil unless exists?
    @res[:vpc_peering_connection_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:vpc_peering_connection_id] : @display_name
  end

  def to_s
    "VPC Peering Connection ID: #{@display_name}"
  end
end
