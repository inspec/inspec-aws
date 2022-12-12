require "aws_backend"

class AWSEC2ClientVPNEndpoints < AwsResourceBase
  name "aws_ec2_client_vpn_endpoints"
  desc "Describes all the VPN endpoint."
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_endpoints do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:client_vpn_endpoint_ids, field: :client_vpn_endpoint_id)
    .register_column(:descriptions, field: :description)
    .register_column(:creation_time, field: :creation_time)
    .register_column(:deletion_time, field: :deletion_time)
    .register_column(:dns_names, field: :dns_name)
    .register_column(:split_tunnels, field: :split_tunnel)
    .register_column(:vpn_protocols, field: :vpn_protocol)
    .register_column(:transport_protocols, field: :transport_protocol)
    .register_column(:vpn_ports, field: :vpn_port)
    .register_column(:server_certificate_arns, field: :server_certificate_arn)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.compute_client.describe_client_vpn_endpoints.map do |resp|
        resp.client_vpn_endpoints.map { |resp_name| {
          client_vpn_endpoint_id: resp_name.client_vpn_endpoint_id,
          description: resp_name.description,
          creation_time: resp_name.creation_time,
          deletion_time: resp_name.deletion_time,
          dns_name: resp_name.dns_name,
          split_tunnel: resp_name.split_tunnel,
          vpn_protocol: resp_name.vpn_protocol,
          transport_protocol: resp_name.transport_protocol,
          vpn_port: resp_name.vpn_port,
          server_certificate_arn: resp_name.server_certificate_arn,
          tags: resp_name.tags,
        }
        }
      end.flatten
    end
  end
end
