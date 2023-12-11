require "aws_backend"

class AwsNetworkACL < AwsResourceBase
  EGRESS = "egress".freeze
  INGRESS = "ingress".freeze
  name "aws_network_acl"
  desc "Verifies settings for a single AWS Network ACL"
  example "
   describe aws_network_acl(network_acl_id: '014aef8a0689b8f43') do
     it { should exist }
   end

   describe aws_network_acl('014aef8a0689b8f43') do
     it { should exist }
   end
  "

  def initialize(opts = {})
    opts = { network_acl_id: opts } if opts.is_a?(String)
    super
    validate_parameters(required: [:network_acl_id])
    validate_identifier
    fetch
  end

  def associated_subnet_ids
    return [] unless associations
    return @associated_subnets if @associated_subnets

    @associated_subnets = associations.map(&:subnet_id)
  end

  # MATCHERS
  def exists?
    !failed_resource? && !!@response && !@response.empty?
  end

  def associated?
    !!associations && !associations.empty?
  end

  def default?
    return false unless exists?

    is_default
  end

  def has_associations?(subnet_id: nil)
    return false unless associated?
    return associated? unless subnet_id

    associated_subnet_ids.any? { |associated_subnet_id| associated_subnet_id == subnet_id }
  end

  def has_acl_entry_value?(cidr_block: nil, egress: nil, icmp_type_code: nil, ipv_6_cidr_block: nil, port_range: nil, protocol: nil, rule_action: nil, rule_number: nil)
    return false unless acl_entries
    
    # rules for all protocols are recorded as rules with protocol == -1
    protocol = "-1" if protocol.to_s.downcase == "all"

    # check for acl entries matching any combination of fields
    # iff a field was passed to the matcher, then it is included as part of the test
    acl_entries.any? { |entry| 
      entry.cidr_block == cidr_block &&
      egress.to_s.present? ? entry.egress == egress : true &&
      icmp_type_code.present? ? entry.icmp_type_code == icmp_type_code : true &&
      ipv_6_cidr_block.present? ? entry.ipv_6_cidr_block == ipv_6_cidr_block : true &&
      port_range.present? ? port_within_range?(entry.port_range, port_range) : true &&
      protocol.present? ? entry.protocol == protocol.to_s : true &&
      rule_action ? entry.rule_action == rule_action : true &&
      rule_number ? entry.rule_number == rule_number : true
    }
  end

  def has_egress?(cidr_block: nil, rule_action: nil)
    cidr_block_and_rule_action_exists_for?(egress, cidr_block, rule_action)
  end

  def has_ingress?(cidr_block: nil, rule_action: nil)
    cidr_block_and_rule_action_exists_for?(ingress, cidr_block, rule_action)
  end

  def egress
    return [] unless acl_entries
    return @egress if @egress

    @egress = acl_entries.select(&:egress)
  end

  def ingress
    return [] unless acl_entries
    return @ingress if @ingress

    @ingress = acl_entries.reject(&:egress)
  end

  def resource_id
    @response ? @response.network_acls.first.network_acl_id : ""
  end

  def to_s
    "Network ACL ID: #{@opts[:network_acl_id]}"
  end

  private

  def fetch
    params = { network_acl_ids: [@opts[:network_acl_id]] }
    @response = query_with(params)
    return empty_response_warn unless @response

    network_acl_hash = network_acl.to_h
    network_acl_hash[:associations] = associations.map do |association|
      { network_acl_association_id: association.network_acl_association_id, subnet_id: association.subnet_id }
    end
    create_resource_methods(network_acl_hash)
    create_rule_number_methods
  end

  def network_acl
    return unless @response

    @response.network_acls.first
  end

  def query_with(params)
    catch_aws_errors do
      @aws.compute_client.describe_network_acls(params)
    end
  end

  def associations
    return [] unless network_acl

    network_acl.associations
  end

  def acl_entries
    return [] unless network_acl

    network_acl.entries
  end

  # creates entry_rule_number_* methods
  def create_rule_number_methods
    entries.each do |entry|
      egress_name = entry.egress ? EGRESS : INGRESS
      method_name = "#{egress_name}_rule_number_#{entry.rule_number}"
      define_singleton_method method_name do
        entry
      end
    end
  end

  def validate_identifier
    raise ArgumentError, "parameter `network_acl_id` cannot be blank" if @opts[:network_acl_id].nil? || @opts[:network_acl_id].empty?
    raise ArgumentError, "parameter `network_acl_id` should start with `acl-` followed by alpha numeric characters" if @opts[:network_acl_id] !~ /^acl-[a-z0-9]+$/
  end

  def cidr_block_and_rule_action_exists_for?(collection, cidr_block, rule_action)
    return !collection.empty? if (cidr_block.nil? || cidr_block.empty?) && (rule_action.nil? || rule_action.empty?)

    if cidr_block && rule_action
      return collection.any? { |entry| entry.cidr_block == cidr_block && entry.rule_action == rule_action }
    end

    collection.any? { |entry| entry.cidr_block == cidr_block || entry.rule_action == rule_action }
  end

  def port_within_range?(acl_port_range, expected_port)
    return false if acl_port_range.nil? || expected_port.nil?
    # compare an Aws::EC2::Types::PortRange to a standard Range
    (acl_port_range.from..acl_port_range.to).include?(expected_port)
  end
end
