# frozen_string_literal: true

require 'aws_backend'

class AwsVPNConnection < AwsResourceBase
  name 'aws_vpn_connection'
  desc 'Verifies settings for a single AWS VPN Connection.'

  example "
   describe aws_vpn_connection(vpn_connection_id: 'vc-014aef8a0689b8f43') do
     it { should exist }
   end

   describe aws_vpn_connection('vc-014aef8a0689b8f43') do
     it { should exist }
   end
  "

  def initialize(opts = {})
    opts = { vpn_connection_id: opts } if opts.is_a?(String)
    super
    validate_parameters(required: [:vpn_connection_id])
    validate_identifier
    fetch
  end

  def exists?
    !failed_resource? && !!@response || !@response.empty?
  end

  def to_s
    "VPN connection ID: #{@opts[:vpn_connection_id]}"
  end

  def resource_id
    @opts ? @opts[:vpn_connection_id] : ''
  end

  private

  def fetch
    params = { vpn_connection_ids: [@opts[:vpn_connection_id]] }
    @response = query_with(params)
    return empty_response_warn unless @response

    create_resource_methods(@response.vpn_connections.first.to_h)
  end

  def query_with(params)
    catch_aws_errors do
      @aws.compute_client.describe_vpn_connections(params)
    end
  end

  def validate_identifier
    raise ArgumentError, 'parameter `vpn_connection_id` cannot be blank' if @opts[:vpn_connection_id].nil? || @opts[:vpn_connection_id].empty?
  end
end
