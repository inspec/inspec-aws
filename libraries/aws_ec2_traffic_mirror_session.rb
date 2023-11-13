require 'aws_backend'

class AWSEc2TrafficMirrorSession < AwsResourceBase
  name 'aws_ec2_traffic_mirror_session'
  desc 'Describes one or more Traffic Mirror session.'

  example "
    describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'test-traffic_mirror_session_id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { traffic_mirror_session_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(traffic_mirror_session_id))
    if opts[:traffic_mirror_session_id] && !opts[:traffic_mirror_session_id].empty? # Use instance_id, if provided
      if !opts[:traffic_mirror_session_id].is_a?(String) || opts[:traffic_mirror_session_id] !~ /(^tms-[0-9a-f]{8})|(^i-[0-9a-f]{17})$/
        raise ArgumentError, "#{@__resource_name__}: `traffic_mirror_session_id` must be a string in the format of 'tms-' followed by 8 or 17 hexadecimal characters."
      end
      @display_name = opts[:traffic_mirror_session_id]
      traffic_mirror_session_arguments = { traffic_mirror_session_ids: [opts[:traffic_mirror_session_id]] }
    end
    catch_aws_errors do
      resp = @aws.compute_client.describe_traffic_mirror_sessions(traffic_mirror_session_arguments)
      @traffic_mirror_session = resp.traffic_mirror_sessions[0].to_h
      create_resource_methods(@traffic_mirror_session)
    end
  end

  def exists?
    !@traffic_mirror_session.nil? && !@traffic_mirror_session.empty?
  end

  def resource_id
    @traffic_mirror_session ? @traffic_mirror_session[:traffic_mirror_session_id] : @display_name
  end

  def to_s
    "EC2 Traffic Mirror Session: #{@display_name}"
  end
end
