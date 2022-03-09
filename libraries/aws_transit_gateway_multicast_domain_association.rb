# frozen_string_literal: true

require 'aws_backend'

class AWSTransitGatewayMulticastDomainAssociation < AwsResourceBase
  name 'aws_transit_gateway_multicast_domain_association'
  desc 'Gets information about the associations for the transit gateway multicast domain.'
  example "
    describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'EC2_TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      its { should exist }
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
    return nil unless exists?
    @multicast_domain_associations[:transit_gateway_multicast_domain_id]
  end

  def exists?
    !@multicast_domain_associations.nil? && !@multicast_domain_associations.empty?
  end

  def to_s
    "EC2 Transit Gateway Multicast Domain ID: #{@display_name}"
  end
end
