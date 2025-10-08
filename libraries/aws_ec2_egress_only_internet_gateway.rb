require "aws_backend"

class AWSEC2EgressOnlyInternetGateway < AwsResourceBase
  name "aws_ec2_egress_only_internet_gateway"
  desc "Describes one egress-only internet gateways."

  example "
    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EGRESS_ONLY_INTERNET_GATEWAY_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { egress_only_internet_gateway_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:egress_only_internet_gateway_id])
    unless opts[:egress_only_internet_gateway_id] &&
             !opts[:egress_only_internet_gateway_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: egress_only_internet_gateway_id must be provided"
    end
    @display_name = opts[:egress_only_internet_gateway_id]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_egress_only_internet_gateways(
          {
            egress_only_internet_gateway_ids: [
              opts[:egress_only_internet_gateway_id]
            ]
          }
        )
      @resp = resp.egress_only_internet_gateways[0].to_h
      create_resource_methods(@resp)
    end
  end

  def egress_only_internet_gateway_id
    return nil unless exists?
    @resp[:egress_only_internet_gateway_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @resp ? @resp[:egress_only_internet_gateway_id] : @display_name
  end

  def to_s
    "Egress Only Internet Gateway Id: #{@display_name}"
  end

  def attachments_states
    attachments.map(&:state)
  end

  def attachments_vpc_ids
    attachments.map(&:vpc_id)
  end
end
