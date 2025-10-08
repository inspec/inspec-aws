require "aws_backend"

class AwsEc2Eip < AwsResourceBase
  name "aws_ec2_eip"
  desc "Specifies an Elastic IP (EIP) address and can, optionally, associate it with an Amazon EC2 instance."

  example "
    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      its('public_ip') { should eq '192.0.2.0' }
    end

    describe aws_ec2_eip('192.0.2.0') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { public_ip: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:public_ip])

    unless opts[:public_ip] && !opts[:public_ip].empty?
      raise ArgumentError, "#{@__resource_name__}: public_ip must be provided"
    end
    @display_name = opts[:public_ip]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_addresses(
          { public_ips: [opts[:public_ip]] }
        )
      @addresses = resp.addresses[0].to_h
      create_resource_methods(@addresses)
    end
  end

  def public_ip
    return nil unless exists?
    @addresses[:public_ip]
  end

  def exists?
    !@addresses.nil? && !@addresses.empty?
  end

  def resource_id
    @addresses ? @addresses[:public_ip] : @display_name
  end

  def to_s
    "Public IP: #{@display_name}"
  end
end
