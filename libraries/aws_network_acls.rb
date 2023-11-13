require "aws_backend"

class AwsNetworkACLs < AwsResourceBase
  name "aws_network_acls"
  desc "Verifies settings for a collection of AWS internet gateways."

  example "
    describe aws_network_acls do
      its('count') { should eq 3 }
    end

    describe aws_network_acls.where{ entries_cidr_blocks.include?('0.0.0.0/0') } do
      it { should exist }
    end
  "

  attr_reader :table

  filter_table_config = FilterTable.create
    .register_column(:network_acl_ids, field: :network_acl_id)
    .register_column(:default, field: :default)
    .register_column(:vpc_ids, field: :vpc_id)
    .register_column(:owner_ids, field: :owner_id)
    .register_column(:tags, field: :tags)
  # fields that needs to be customized as flattened Arrays
  %i(default_network_acl_ids associated_subnet_ids network_acl_association_ids entries_cidr_blocks entries_cidr_egress entries_icmp_type_codes
     entries_icmp_type_code_types entries_ipv_6_cidr_blocks entries_port_ranges entries_protocols entries_rule_actions
     entries_rule_numbers egress_rule_numbers ingress_rule_numbers).each do |column|
       filter_table_config.send(:register_column, column, field: column, style: :simple)
     end

  filter_table_config.install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    network_acls = []
    paginate_request do |api_response|
      network_acls += api_response.network_acls.map do |network_acl|
        flat_hash_from(network_acl)
      end
    end
    network_acls
  end

  private

  def paginate_request
    pagination_options = { max_results: 100 }
    loop do
      api_response = catch_aws_errors do
        @aws.compute_client.describe_network_acls(pagination_options)
      end
      return [] if api_response.nil? || api_response.empty?

      yield api_response
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
  end

  def flat_hash_from(network_acl)
    network_acl_hash = network_acl.to_h
    network_acl_hash[:default] = network_acl_hash[:is_default]
    network_acl_hash[:default_network_acl_ids] = network_acl_hash.delete(:is_default) ? network_acl.network_acl_id : nil
    # Associations
    network_acl_hash[:associated_subnet_ids] = mappable_attribute_from(network_acl.associations, "subnet_id")
    network_acl_hash[:network_acl_association_ids] = mappable_attribute_from(network_acl.associations, "network_acl_association_id")
    # Entries
    network_acl_hash[:entries_cidr_blocks] = mappable_attribute_from(network_acl.entries, "cidr_block")
    network_acl_hash[:entries_cidr_egress] = mappable_attribute_from(network_acl.entries, "egress")
    network_acl_hash[:entries_icmp_type_codes] = mappable_attribute_from(network_acl.entries, "icmp_type_code&.code")
    network_acl_hash[:entries_icmp_type_code_types] = mappable_attribute_from(network_acl.entries, "icmp_type_code&.type")
    network_acl_hash[:entries_ipv_6_cidr_blocks] = mappable_attribute_from(network_acl.entries, "ipv_6_cidr_block")
    network_acl_hash[:entries_port_ranges] = mapped_port_ranges_for(network_acl.entries)
    network_acl_hash[:entries_protocols] = mappable_attribute_from(network_acl.entries, "protocol")
    network_acl_hash[:entries_rule_actions] = mappable_attribute_from(network_acl.entries, "rule_action")
    network_acl_hash[:entries_rule_numbers] = mappable_attribute_from(network_acl.entries, "rule_number")
    network_acl_hash[:egress_rule_numbers] = mappable_attribute_from(network_acl.entries.select(&:egress), "rule_number")
    network_acl_hash[:ingress_rule_numbers] = mappable_attribute_from(network_acl.entries.reject(&:egress), "rule_number")
    # Tags
    network_acl_hash[:tags] = network_acl.tags.empty? ? nil : map_tags(network_acl.tags)
    network_acl_hash.delete(:associations)
    network_acl_hash.delete(:entries)
    network_acl_hash
  end

  # attribute can be a nested method chain call
  def mappable_attribute_from(collection, attribute)
    collection.map { |item| item.instance_eval(attribute) }
  end

  def mapped_port_ranges_for(entries)
    entries.map do |entry|
      port_range = entry.port_range
      next unless port_range
      (port_range.from..port_range.to).to_a
    end
  end
end
