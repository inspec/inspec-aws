require "aws_backend"

class AWSNetworkManagerDevice < AwsResourceBase
  name "aws_network_manager_device"
  desc "Gets information about one or more of your devices in a global network."

  example "
    describe aws_network_manager_device(device_id: 'test1', global_network_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { global_network_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(device_id global_network_id))
    raise ArgumentError, "#{@__resource_name__}: device_id must be provided" unless opts[:device_id] && !opts[:device_id].empty?
    @display_name = opts[:device_id]
    catch_aws_errors do
      resp = @aws.network_manager_client.get_devices({ device_ids: [opts[:device_id]], global_network_id: opts[:global_network_id] })
      @res = resp.devices[0].to_h
      create_resource_methods(@res)
    end
  end

  def device_id
    return unless exists?
    @res[:device_id]
  end

  def resource_id
    @res? @res[:device_id]: @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Device ID: #{@display_name}"
  end
end
