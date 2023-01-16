require "aws_backend"

class AwsVPNConnection < AwsResourceBase
  name "aws_vpn_connection"
  desc "Verifies settings for a single AWS VPN Connection."
  example <<-EXAMPLE
     describe aws_vpn_connection(vpn_connection_id: 'vpn-1234567890') do
       it { should exist }
     end
     describe aws_vpn_connection('vpn-1234567890') do
       it { should exist }
     end
  EXAMPLE

  def initialize(opts = {})
    opts = { vpn_connection_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpn_connection_id])
    validate_identifier
    @display_name = @opts[:vpn_connection_id]
    fetch
  end

  def exists?
    !@response.blank?
  end

  def to_s
    "VPN Connection ID: #{@display_name}"
  end

  def resource_id
    @response ? @response.vpn_connections.first.vpn_connection_id : @display_name
  end

  private

  def fetch
    params = { vpn_connection_ids: [@display_name] }
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
    raise ArgumentError, "parameter `vpn_connection_id` cannot be blank" if @opts[:vpn_connection_id].blank?
  end
end
