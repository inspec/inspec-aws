require "aws_backend"

class AWSTransitGatewayMulticastGroupSource < AwsResourceBase
  name "aws_transit_gateway_multicast_group_source"
  desc "Searches one or more transit gateway multicast groups and returns the group membership information."

  example "
    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: 'test') do
      it { should exist }
    end

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: 'test') do
      its ('group_ip_address') { should eq '224.0.0.1' }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_multicast_domain_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_multicast_domain_id])
    unless opts[:transit_gateway_multicast_domain_id] &&
             !opts[:transit_gateway_multicast_domain_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: transit_gateway_multicast_domain_id must be provided"
    end
    @display_name = opts[:transit_gateway_multicast_domain_id]
    catch_aws_errors do
      resp =
        @aws.compute_client.search_transit_gateway_multicast_groups(
          {
            transit_gateway_multicast_domain_id:
              opts[:transit_gateway_multicast_domain_id]
          }
        )
      @multicast_groups = resp.multicast_groups[0].to_h
      create_resource_methods(@multicast_groups)
    end
  end

  def transit_gateway_multicast_domain_id
    return nil unless exists?
    @multicast_groups[:transit_gateway_multicast_domain_id]
  end

  def exists?
    !@multicast_groups.nil? && !@multicast_groups.empty?
  end

  def resource_id
    if @multicast_groups
      @multicast_groups[:transit_gateway_multicast_domain_id]
    else
      @display_name
    end
  end

  def to_s
    "Transit Gateway Multicast Domain ID: #{@display_name}"
  end
end
