require "aws_backend"

class AWSNetworkManagerCustomerGatewayAssociation < AwsResourceBase
  name "aws_network_manager_customer_gateway_association"
  desc "Gets the association information for customer gateways that are associated with devices and links in your global network."

  example "
    describe aws_network_manager_customer_gateway_association(global_network_id: 'GlobalNetworkID', customer_gateway_arn: 'CustomerGatewayARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { global_network_id: opts } if opts.is_a?(String)
    opts = { customer_gateway_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(global_network_id customer_gateway_arn))
    raise ArgumentError, "#{@__resource_name__}: global_network_id must be provided" unless opts[:global_network_id] && !opts[:global_network_id].empty?
    raise ArgumentError, "#{@__resource_name__}: customer_gateway_arn must be provided" unless opts[:customer_gateway_arn] && !opts[:customer_gateway_arn].empty?
    @display_name = opts[:customer_gateway_arn]
    catch_aws_errors do
      resp = @aws.network_manager_client.get_customer_gateway_associations({ global_network_id: opts[:global_network_id], customer_gateway_arns: [opts[:customer_gateway_arn]] })
      @res = resp.customer_gateway_associations[0].to_h
      create_resource_methods(@res)
    end
  end

  def customer_gateway_arn
    return nil unless exists?
    @res[:customer_gateway_arn]
  end

  def resource_id
    @res? @res[:customer_gateway_arn]: @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Customer Gateway ARN: #{@display_name}"
  end
end
