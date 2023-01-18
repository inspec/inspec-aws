require "aws_backend"

class AwsNatGateway < AwsResourceBase
  name "aws_nat_gateway"
  desc "Verifies settings for an AWS NAT Gateway."

  example "
    describe aws_nat_gateway(id: 'nat-11aa578bffadf6ba6') do
      it { should exist }
    end

    describe aws_nat_gateway(vpc_id: 'vpc-11aa578bccadf6b77') do
      it { should exist }
    end

    describe aws_nat_gateway(name: 'my-nat-gateway') do
      it { should exist }
    end

    describe aws_nat_gateway(subnet_id: 'subnet-00bbde2bccada6b33') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(id vpc_id name subnet_id))

    # This filter will be used in the API call.
    filter = []
    if opts.key?(:id)
      id = opts[:id].to_s
      raise ArgumentError, "#{@__resource_name__}: `id` must be a string in the format of 'nat-' followed by 8 or 17 hexadecimal characters." unless /^nat-[0-9a-f]{8,17}$/.match?(id)
      filter << { name: "nat-gateway-id", values: [id] }
    end
    if opts.key?(:name)
      name = opts[:name].to_s
      raise ArgumentError, "#{@__resource_name__}: `name` must be maximum 255 characters long." unless name.length < 256
      filter << { name: "tag:Name", values: [name] }
    end
    if opts.key?(:vpc_id)
      vpc_id = opts[:vpc_id].to_s
      raise ArgumentError, "#{@__resource_name__}: `vpc_id` must be a string in the format of 'vpc-' followed by 8 or 17 hexadecimal characters." unless /^vpc-[0-9a-f]{8,17}$/.match?(vpc_id)
      filter << { name: "vpc-id", values: [vpc_id] }
    end
    if opts.key?(:subnet_id)
      subnet_id = opts[:subnet_id].to_s
      raise ArgumentError, "#{@__resource_name__}: `subnet_id` must be a string in the format of 'subnet-' followed by 8 or 17 hexadecimal characters." unless /^subnet-[0-9a-f]{8,17}$/.match?(subnet_id)
      filter << { name: "subnet-id", values: [subnet_id] }
    end
    @display_name = opts.slice(:id, :subnet_id, :name, :vpc_id).values.join(" ")

    query_params = { filter: filter }
    catch_aws_errors do
      resp = @aws.compute_client.describe_nat_gateways(query_params)
      if resp.nat_gateways.empty?
        empty_response_warn
      elsif resp.nat_gateways.count > 1
        resource_fail
      else
        @nat_gateway = resp.nat_gateways.first.to_h
        create_resource_methods(@nat_gateway)
      end
    end
  end

  def nat_gateway_address_set
    # You can associate exactly one Elastic IP address with a NAT gateway.
    # https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html
    nat_gateway_addresses&.first&.item
  end

  def id
    nat_gateway_id if exists?
  end

  def exists?
    !failed_resource?
  end

  def resource_id
    @nat_gateway ? @nat_gateway[:nat_gateway_id]: @display_name
  end

  def to_s
    "NAT Gateway #{@display_name}"
  end
end
