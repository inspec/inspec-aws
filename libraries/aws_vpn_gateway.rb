require 'aws_backend'

class AwsVPNGateway < AwsResourceBase
  name 'aws_vpn_gateway'
  desc 'Verifies settings for a single AWS VPN Gateway.'

  example "
   describe aws_vpn_gateway(vpn_gateway_id: 'vgw-014aef8a0689b8f43') do
     it { should exist }
   end

   describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
     it { should exist }
   end
  "

  def initialize(opts = {})
    opts = { vpn_gateway_id: opts } if opts.is_a?(String)
    super
    validate_parameters(required: [:vpn_gateway_id])
    validate_identifier
    fetch
  end

  def exists?
    !failed_resource? && !!@response || !@response.empty?
  end

  def to_s
    "VPN Gateway ID: #{@opts[:vpn_gateway_id]}"
  end

  def vpc_id
    return NullResponse unless attached?

    attachments.first.vpc_id
  end

  def attached?
    return false if attachments.nil? || attachments.empty?

    attachments.first.state == 'attached'
  end

  def detached?
    !attached?
  end

  def resource_id
    @opts ? @opts[:vpn_gateway_id] : ''
  end

  private

  def fetch
    params = { vpn_gateway_ids: [@opts[:vpn_gateway_id]] }
    @response = query_with(params)
    return empty_response_warn unless @response

    create_resource_methods(@response.vpn_gateways.first.to_h)
  end

  def query_with(params)
    catch_aws_errors do
      @aws.compute_client.describe_vpn_gateways(params)
    end
  end

  def attachments
    return [] unless exists?

    @response.vpn_gateways.first.vpc_attachments
  end

  def validate_identifier
    raise ArgumentError, 'parameter `vpn_gateway_id` cannot be blank' if @opts[:vpn_gateway_id].nil? || @opts[:vpn_gateway_id].empty?
    raise ArgumentError, 'parameter `vpn_gateway_id` should start with `vgw-` followed by alpha numeric characters' if @opts[:vpn_gateway_id] !~ /^vgw-[a-z0-9]+$/
  end
end
