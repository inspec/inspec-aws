require 'aws_backend'

class AWSTransitGatewayMulticastDomainAssociation < AwsResourceBase
  name 'aws_transit_gateway_multicast_domain_association'
  desc 'Gets information about the associations for the transit gateway multicast domain.'

  example "
    describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'Domain ID') do
      its { should exist }
    end

    describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'Domain ID') do
      its('transit_gateway_multicast_domain_id') { should eq 'Domain ID' }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: [:transit_gateway_multicast_domain_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_multicast_domain_id must be provided" unless opts[:transit_gateway_multicast_domain_id] && !opts[:transit_gateway_multicast_domain_id].empty?
    @display_name = opts[:transit_gateway_multicast_domain_id]
    catch_aws_errors do
      resp = @aws.compute_client.get_transit_gateway_multicast_domain_associations({ transit_gateway_multicast_domain_id: opts[:transit_gateway_multicast_domain_id] })
      @multicast_domain_associations = resp.multicast_domain_associations[0].to_h
      create_resource_methods(@multicast_domain_associations)
    end
  end

  def transit_gateway_multicast_domain_id
    return unless exists?
    @multicast_domain_associations[:transit_gateway_multicast_domain_id]
  end

  def exists?
    !@multicast_domain_associations.nil? && !@multicast_domain_associations.empty?
  end

  def resource_id
    @multicast_domain_associations ? @multicast_domain_associations[:transit_gateway_multicast_domain_id] : @display_name
  end

  def to_s
    "Transit Gateway Multicast Domain ID: #{@display_name}"
  end
end
