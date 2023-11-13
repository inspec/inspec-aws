require 'aws_backend'

class AWSEC2ClientVPNTargetNetworkAssociations < AwsResourceBase
  name 'aws_ec2_client_vpn_target_network_associations'
  desc 'Describes all the AWS EC2 Client Vpn Target Network Association.'
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:association_ids, field: :association_id)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:target_network_ids, field: :target_network_id)
             .register_column(:client_vpn_endpoint_ids, field: :client_vpn_endpoint_id)
             .register_column(:status_codes, field: :status_code)
             .register_column(:status_messages, field: :status_message)
             .register_column(:security_groups, field: :security_groups, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(client_vpn_endpoint_id))
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.compute_client.describe_client_vpn_target_networks({ client_vpn_endpoint_id: opts[:client_vpn_endpoint_id] }).map do |resp|
        resp.client_vpn_target_networks.map { |resp_name| {
          association_id: resp_name.association_id,
          vpc_id: resp_name.vpc_id,
          target_network_id: resp_name.target_network_id,
          client_vpn_endpoint_id: resp_name.client_vpn_endpoint_id,
          status_code: resp_name.status.code,
          status_message: resp_name.status.message,
          security_groups: resp_name.security_groups,
        }
        }
      end.flatten
    end
  end
end
