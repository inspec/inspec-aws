require 'aws_backend'

class AwsVpc < AwsResourceBase
  name 'aws_vpc'
  desc 'Verifies settings for an AWS VPC.'

  example "
    describe aws_vpc(vpc_id: 'vpc-12345678') do
      it { should exist }
    end
  "

  STATES = %w{pending available}.freeze
  INSTANCE_TENDENCIES = %w{default dedicated host}.freeze
  CIDR_BLOCK_STATES = %w{associating associated disassociating disassociated failing failed}.freeze

  def initialize(opts = {})
    opts = { vpc_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(allow: [:vpc_id])

    if opts[:vpc_id].nil?
      @display_name = 'default'
      filter = { name: 'isDefault', values: ['true'] }
    else
      @display_name = opts[:vpc_id]
      raise ArgumentError, "#{@__resource_name__}: VPC ID must be in the format 'vpc-' followed by 8 or 17 hexadecimal characters." if opts[:vpc_id] !~ /^vpc\-([0-9a-f]{8})|(^vpc\-[0-9a-f]{17})$/
      filter = { name: 'vpc-id', values: [opts[:vpc_id]] }
    end

    catch_aws_errors do
      @response = @aws.compute_client.describe_vpcs({ filters: [filter] })
    end

    vpc_hash = vpc.to_h
    vpc_hash.delete(:ipv_6_cidr_block_association_set)
    vpc_hash.delete(:cidr_block_association_set)
    create_resource_methods(vpc_hash)
  end

  # matchers
  STATES.each do |state|
    define_method "#{state}?" do
      vpc&.state == state
    end
  end

  INSTANCE_TENDENCIES.each do |tendency|
    method_name = "#{tendency}_instance?"
    define_method method_name do
      vpc&.instance_tenancy == tendency
    end
  end

  def default?
    vpc.is_default
  end

  def exists?
    !!vpc && !vpc.empty?
  end

  def resource_id
    @response ? @display_name : ''
  end

  def has_cidr_block_associated?(cidr_block)
    return false if associated_cidr_blocks.empty?

    associated_cidr_blocks.include?(cidr_block)
  end

  # will return false if the given CIDR block is not present in failed associations and it does not mean the CIDR block is associated
  def has_cidr_block_association_failed?(cidr_block)
    return false if failed_cidr_blocks.empty?

    failed_cidr_blocks.include?(cidr_block)
  end

  # will return false if the given CIDR block is not present in disassociation state and it does not mean the CIDR block is associated
  def has_cidr_block_disassociated?(cidr_block)
    return false if disassociated_cidr_blocks.empty?

    disassociated_cidr_blocks.include?(cidr_block)
  end

  def has_ipv6_cidr_block_associated?(ipv6_cidr_block)
    return false if associated_ipv6_cidr_blocks.empty?

    associated_ipv6_cidr_blocks.include?(ipv6_cidr_block)
  end

  # will return false if the given CIDR block is not present in failed associations and it does not mean the CIDR block is associated
  def has_ipv6_cidr_block_association_failed?(ipv6_cidr_block)
    return false if failed_ipv6_cidr_blocks.empty?

    failed_ipv6_cidr_blocks.include?(ipv6_cidr_block)
  end

  # will return false if the given CIDR block is not present in disassociation state and it does not mean the CIDR block is associated
  def has_ipv6_cidr_block_disassociated?(ipv6_cidr_block)
    return false if disassociated_ipv6_cidr_blocks.empty?

    disassociated_ipv6_cidr_blocks.include?(ipv6_cidr_block)
  end

  def has_network_border_group_value?(ipv6_cidr_block:, network_border_group:)
    raise ArgumentError, 'parameters `ipv6_cidr_block` and `network_border_group` should be present' unless ipv6_cidr_block && network_border_group

    ipv6_cidr_block_associations.any? { |assoc| assoc.ipv_6_cidr_block == ipv6_cidr_block && assoc.network_border_group == network_border_group }
  end

  def has_ipv6_pool_value?(ipv6_cidr_block:, ipv6_pool:)
    raise ArgumentError, 'parameters `ipv6_cidr_block` and `ipv6_pool` should be present' unless ipv6_cidr_block && ipv6_pool

    ipv6_cidr_block_associations.any? { |assoc| assoc.ipv_6_cidr_block == ipv6_cidr_block && assoc.ipv_6_pool == ipv6_pool }
  end

  # defines <state>_ipv6_cidr_blocks and <state>_cidr_blocks
  # returns valid CIDR blocks matching current state and IP range
  # @example
  # associated_ipv6_cidr_blocks and associated_cidr_blocks
  CIDR_BLOCK_STATES.each do |state|
    define_method "#{state}_ipv6_cidr_blocks" do
      filter(ipv6_cidr_block_associations) { |association| association.ipv_6_cidr_block if association.ipv_6_cidr_block_state.state == state }
    end

    define_method "#{state}_cidr_blocks" do
      filter(cidr_block_associations) { |association| association.cidr_block if association.cidr_block_state.state == state }
    end
  end

  def to_s
    opts.key?(:aws_region) ? "VPC #{@display_name} in #{opts[:aws_region]}" : "VPC #{@display_name}"
  end

  private

  def cidr_block_associations
    return [] unless vpc

    vpc.cidr_block_association_set
  end

  def ipv6_cidr_block_associations
    return [] unless vpc

    vpc.ipv_6_cidr_block_association_set
  end

  def vpc
    return unless @response

    @vpc ||= @response.vpcs.first
  end

  def filter(associations, &block)
    # support for better performance filter_map is available only after ruby-2.7
    # https://blog.saeloun.com/2019/05/25/ruby-2-7-enumerable-filter-map.html
    if associations.respond_to?(:filter_map)
      associations.filter_map(&block)
    else # backward compatible for ruby version < 2.7
      associations.map(&block).compact
    end
  end
end
