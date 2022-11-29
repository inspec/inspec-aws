require 'aws_backend'

class AWSRoute53ResolverResolverEndpoint < AwsResourceBase
  name 'aws_route53resolver_resolver_endpoint'
  desc 'Gets information about a specified Resolver endpoint, such as whether its an inbound or an outbound Resolver endpoint, and the current status of the endpoint.'

  example "
    describe aws_route53resolver_resolver_endpoint(resolver_endpoint_id: 'ResourceId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { resolver_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(resolver_endpoint_id))
    raise ArgumentError, "#{@__resource_name__}: resolver_endpoint_id must be provided" unless opts[:resolver_endpoint_id] && !opts[:resolver_endpoint_id].empty?
    @display_name = opts[:resolver_endpoint_id]
    catch_aws_errors do
      resp = @aws.route53resolver_client.get_resolver_endpoint({ resolver_endpoint_id: opts[:resolver_endpoint_id] })
      @res = resp.resolver_endpoint.to_h
      create_resource_methods(@res)
    end
  end

  def resolver_endpoint_id
    return nil unless exists?
    @res[:id]
  end

  def resource_id
    @res? @res[:id]: @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Resolver Endpoint ID: #{@display_name}"
  end
end
