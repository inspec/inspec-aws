require 'aws_backend'

class AWSTransitGatewayMulticastDomain < AwsResourceBase
  name 'aws_transit_gateway_multicast_domain'
  desc 'Describes one or more transit gateway multicast domains.'

  example "
    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'Domain ID') do
      it { should exist }
    end

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'Domain ID') do
      its('transit_gateway_multicast_domain_id') { should eq 'Domain ID' }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_multicast_domain_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_multicast_domain_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_multicast_domain_id must be provided" unless opts[:transit_gateway_multicast_domain_id] && !opts[:transit_gateway_multicast_domain_id].empty?
    @display_name = opts[:transit_gateway_multicast_domain_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateway_multicast_domains({ transit_gateway_multicast_domain_ids: [opts[:transit_gateway_multicast_domain_id]] })
      @transit_gateway_multicast_domains = resp.transit_gateway_multicast_domains[0].to_h
      create_resource_methods(@transit_gateway_multicast_domains)
    end
  end

  def transit_gateway_multicast_domain_id
    return nil unless exists?
    @transit_gateway_multicast_domains[:transit_gateway_multicast_domain_id]
  end

  def exists?
    !@transit_gateway_multicast_domains.nil? && !@transit_gateway_multicast_domains.empty?
  end

  def resource_id
    @transit_gateway_multicast_domains ? @transit_gateway_multicast_domains[:transit_gateway_multicast_domain_id] : @display_name
  end

  def to_s
    "Transit Gateway Multicast Domain ID: #{@display_name}"
  end
end
