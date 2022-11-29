require 'aws_backend'

class AWSEC2NetworkInterfaces < AwsResourceBase
  name 'aws_ec2_network_interfaces'
  desc 'List all the network interfaces.'

  example "
    describe aws_ec2_network_interfaces do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:associations, field: :association)
             .register_column(:attachments, field: :attachment)
             .register_column(:availability_zones, field: :availability_zone)
             .register_column(:descriptions, field: :description)
             .register_column(:groups, field: :groups)
             .register_column(:interface_types, field: :interface_type)
             .register_column(:ipv_6_addresses, field: :ipv_6_addresses)
             .register_column(:mac_addresses, field: :mac_address)
             .register_column(:network_interface_ids, field: :network_interface_id)
             .register_column(:outpost_arns, field: :outpost_arn)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:private_dns_names, field: :private_dns_name)
             .register_column(:private_ip_addresses, field: :private_ip_address)
             .register_column(:requester_ids, field: :requester_id)
             .register_column(:requester_managed, field: :requester_managed)
             .register_column(:source_dest_checks, field: :source_dest_check)
             .register_column(:statuses, field: :status)
             .register_column(:subnet_ids, field: :subnet_id)
             .register_column(:tag_sets, field: :tag_set)
             .register_column(:vpc_ids, field: :vpc_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_network_interfaces(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.network_interfaces.each do |resp|
        rows += [{ association: resp.association,
                   attachment: resp.attachment,
                   availability_zone: resp.availability_zone,
                   description: resp.description,
                   groups: resp.groups,
                   interface_type: resp.interface_type,
                   ipv_6_addresses: resp.ipv_6_addresses,
                   mac_address: resp.mac_address,
                   network_interface_id: resp.network_interface_id,
                   outpost_arn: resp.outpost_arn,
                   owner_id: resp.owner_id,
                   private_dns_name: resp.private_dns_name,
                   private_ip_address: resp.private_ip_address,
                   requester_id: resp.requester_id,
                   requester_managed: resp.requester_managed,
                   source_dest_check: resp.source_dest_check,
                   status: resp.status,
                   subnet_id: resp.subnet_id,
                   tag_set: resp.tag_set,
                   vpc_id: resp.vpc_id }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
