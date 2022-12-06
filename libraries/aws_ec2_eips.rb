require 'aws_backend'

class AwsEc2Eips < AwsResourceBase
  name 'aws_ec2_eips'
  desc 'Specifies an Elastic IP (EIP) address and can, optionally, associate it with an Amazon EC2 instance.'

  example "
    describe aws_ec2_eips do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:instance_ids,                   field: :instance_id)
             .register_column(:public_ips,                     field: :public_ip)
             .register_column(:allocation_ids,                 field: :allocation_id)
             .register_column(:domains,                        field: :domain)
             .register_column(:association_ids,                field: :association_id)
             .register_column(:network_interface_ids,          field: :network_interface_id)
             .register_column(:network_interface_owner_ids,    field: :network_interface_owner_id)
             .register_column(:private_ip_addresss,            field: :private_ip_address)
             .register_column(:public_ipv_4_pools,             field: :public_ipv_4_pool)
             .register_column(:network_border_groups,          field: :network_border_group)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @addrs = @aws.compute_client.describe_addresses
    end
    return [] if !@addrs || @addrs.empty?
    @table = @addrs.addresses.map(&:to_h)
  end
end
