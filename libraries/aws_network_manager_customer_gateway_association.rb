# frozen_string_literal: true

require 'aws_backend'

class AWSNetworkManagerCustomerGatewayAssociation < AwsResourceBase
  name 'aws_network_manager_customer_gateway_association'
  desc 'Gets the association information for customer gateways that are associated with devices and links in your global network.'

  example "
    describe aws_network_manager_customer_gateway_association(global_network_id: 'GlobalNetworkID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { global_network_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:global_network_id])
    raise ArgumentError, "#{@__resource_name__}: global_network_id must be provided" unless opts[:global_network_id] && !opts[:global_network_id].empty?
    @display_name = opts[:global_network_id]
    catch_aws_errors do
      resp = @aws.network_manager_client.get_customer_gateway_associations({ global_network_id: [opts[:global_network_id]] })
      @res = resp.customer_gateway_associations[0].to_h
      create_resource_methods(@res)
    end
  end

  def global_network_id
    return nil unless exists?
    @res[:global_network_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Global Network ID: #{@display_name}"
  end
end
