# frozen_string_literal: true

require 'aws_backend'

class AwsNetworkACL < AwsResourceBase
  name 'aws_network_acl'
  desc 'Verifies settings for a single AWS Network ACL'

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

  def exists?
    !failed_resource? || !@response.blank?
  end

  def attached?
    !associations.blank?
  end

  def detached?
    !attached?
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
    network_acl_hash[:ingress] = entries.select { |entry| !entry.egress }.map(&:to_h)
    network_acl_hash[:egress] = entries.select { |entry| entry.egress }.map(&:to_h)
    network_acl_hash.delete(:entries)
    create_resource_methods(network_acl_hash)
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

  def entries
    return [] unless network_acl

    network_acl.entries
  end

  def validate_identifier
    raise ArgumentError, 'parameter `network_acl_id` cannot be blank' if @opts[:network_acl_id].blank?
    raise ArgumentError, 'parameter `network_acl_id` should start with `vgw-` followed by alpha numeric characters' if @opts[:network_acl_id] !~ /^acl-[a-z0-9]+$/
  end
end
