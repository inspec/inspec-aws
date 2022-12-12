require "aws_backend"

class AWSEC2NetworkInterfaceAttachment < AwsResourceBase
  name "aws_ec2_network_interface_attachment"
  desc "Describes one or more of your network interface attachment."

  example "
    describe aws_ec2_network_interface_attachment(network_interface_id: 'NetworkInterfaceId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { network_interface_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:network_interface_id])
    raise ArgumentError, "#{@__resource_name__}: network_interface_id must be provided" unless opts[:network_interface_id] && !opts[:network_interface_id].empty?
    @display_name = opts[:network_interface_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_network_interfaces({ network_interface_ids: [opts[:network_interface_id]] })
      @res = resp.network_interfaces[0].attachment.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @display_name : ""
  end

  def to_s
    "Network Interface ID: #{@display_name}"
  end
end
