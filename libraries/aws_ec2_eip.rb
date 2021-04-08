# frozen_string_literal: true

require 'aws_backend'

class AwsEc2Eip < AwsResourceBase
  name 'aws_ec2_eip'
  desc "Verifies settings for EIP"
  example ""

  def initialize(opts = {})
    opts = { public_ip: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:public_ip])

    if opts[:public_ip] && !opts[:public_ip].empty?
      #raise ArgumentError, "#{@__resource_name__}:  must be in the format 'i- followed by 8 or 17 hexadecimal characters." if opts[:instance_id] !~ /^i\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
      require 'pry'
      @display_name = opts[:public_ip]

      #filter = {name: 'public_ip', values: [opts[:public_ip]]}
      filter = [{name: 'public_ip', values: [opts[:public_ip]]}]
      binding.pry
    else
      raise ArgumentError, "#{@__resource_name__}:  `public_ip` must be provided"
    end

    catch_aws_errors do
      #resp = @aws.compute_client.describe_addresses(instance_arguments)
      resp = @aws.compute_client.describe_addresses({public_ips: [opts[:public_ip]]})
      @addresses = resp.addresses[0].to_h
      
      create_resource_methods(@addresses)
    end
  end

  def id
    return nil unless exists?
    @volume[:public_ip]
  end

  def exists?
    !@addresses.nil? && !@addresses.empty?
  end

  def encrypted?
    @addresses[:encrypted]
  end

  def to_s
    "EIP #{@display_name}"
  end
end



#   def initialize(opts = {})
#     super(opts)
#     validate_parameters(require_any_of: %i(instance_id ))

#     # This filter will be used in the API call.
#     filter = []
#     if opts.key?(:instance_id)
#       id = opts[:instance_id].to_s
#       raise ArgumentError, "#{@__resource_name__}: `instance_id` must be a string in the format of 'nat-' followed by 8 or 17 hexadecimal characters." unless /^i-[0-9a-f]{8,17}$/.match?(instance_id)
#       filter << { name: 'i-', values: [instance_id] }
#     end
#     if opts.key?(:vpc_id)
#       vpc_id = opts[:vpc_id].to_s
#       raise ArgumentError, "#{@__resource_name__}: `vpc_id` must be a string in the format of 'vpc-' followed by 8 or 17 hexadecimal characters." unless /^vpc-[0-9a-f]{8,17}$/.match?(vpc_id)
#       filter << { name: 'vpc-id', values: [vpc_id] }
#     end
#     @display_name = opts.slice(:instance_id, :vpc_id).values.join(' ')

#     query_params = { filter: filter }
#     catch_aws_errors do
#       resp = @aws.compute_client.describe_addresses(query_params)
#       if resp.addresses.empty?
#         empty_response_warn
#       else
#         @addresses = resp.addresses.first.to_h
#         create_resource_methods(@addresses)
#       end
#     end
#   end

#   # def nat_gateway_address_set
#   #   # You can associate exactly one Elastic IP address with a NAT gateway.
#   #   # https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html
#   #   nat_gateway_addresses&.first&.item
#   # end

#   def id
#     instance_id if exists?
#   end

#   def exists?
#     !failed_resource?
#   end

#   def to_s
#     "EIP #{@display_name}"
#   end
# end
