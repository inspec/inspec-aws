require "aws_backend"

class AWSEC2ClientVPNAuthorizationRules < AwsResourceBase
  name "aws_ec2_client_vpn_authorization_rules"
  desc "Describes all the VPN rules."
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_authorization_rules(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:client_vpn_endpoint_ids, field: :client_vpn_endpoint_id)
    .register_column(:destination_cidr, field: :destination_cidr)
    .register_column(:group_ids, field: :group_id)
    .register_column(:access_all, field: :access_all)
    .register_column(:status_codes, field: :status_code)
    .register_column(:status_messages, field: :status_message)
    .register_column(:descriptions, field: :description)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(client_vpn_endpoint_id))
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.compute_client.describe_client_vpn_authorization_rules({ client_vpn_endpoint_id: opts[:client_vpn_endpoint_id] }).map do |resp|
        resp.authorization_rules.map { |resp_name| {
          client_vpn_endpoint_id: resp_name.client_vpn_endpoint_id,
          destination_cidr: resp_name.destination_cidr,
          group_id: resp_name.group_id,
          access_all: resp_name.access_all,
          status_code: resp_name.status.code,
          status_message: resp_name.status.message,
          description: resp_name.description,
        }
        }
      end.flatten
    end
  end
end
