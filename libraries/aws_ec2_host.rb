require 'aws_backend'

class AWSEC2Host < AwsResourceBase
  name 'aws_ec2_host'
  desc 'Describes the specified Dedicated Host.'

  example "
    describe aws_ec2_host(host_id: 'DEDICATED_HOST_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { host_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:host_id])
    raise ArgumentError, "#{@__resource_name__}: host_id must be provided" unless opts[:host_id] && !opts[:host_id].empty?
    @display_name = opts[:host_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_hosts({ host_ids: [opts[:host_id]] })
      @resp = resp.hosts[0].to_h
      create_resource_methods(@resp)
    end
  end

  def host_id
    return unless exists?
    @resp[:host_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @resp ? @resp[:host_id] : @display_name
  end

  def to_s
    "Host Id: #{@display_name}"
  end
end
