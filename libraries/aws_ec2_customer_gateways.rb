require "aws_backend"

class AWSEC2CustomerGateways < AwsResourceBase
  name "aws_ec2_customer_gateways"
  desc "Describes one or more of your VPN customer gateways."
  example <<-EXAMPLE
    describe aws_ec2_customer_gateways do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:bgp_asns, field: :bgp_asn)
    .register_column(:customer_gateway_ids, field: :customer_gateway_id)
    .register_column(:ip_addresses, field: :ip_address)
    .register_column(:certificate_arns, field: :certificate_arn)
    .register_column(:states, field: :state)
    .register_column(:types, field: :type)
    .register_column(:device_names, field: :device_name)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.compute_client.describe_customer_gateways
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.customer_gateways.map(&:to_h)
  end
end
