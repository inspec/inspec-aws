require 'aws_backend'

class AWSEc2TrafficMirrorFilter < AwsResourceBase
  name 'aws_ec2_traffic_mirror_filter.md'
  desc 'Describes one or more Traffic Mirror filters.'

  example "
    describe aws_ec2_traffic_mirror_filter_rule(traffic_mirror_filter_id: 'tmf-1234567890') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { traffic_mirror_filter_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(traffic_mirror_filter_id))
    if opts[:traffic_mirror_filter_id] && !opts[:traffic_mirror_filter_id].empty? # Use instance_id, if provided
      if !opts[:traffic_mirror_filter_id].is_a?(String) || opts[:traffic_mirror_filter_id] !~ /(^tmf-[0-9a-f]{8})|(^tmf-[0-9a-f]{17})$/
        raise ArgumentError, "#{@__resource_name__}: `traffic_mirror_filter_id` must be a string in the format of 'tfm-' followed by 8 or 17 hexadecimal characters."
      end
      @display_name = opts[:traffic_mirror_filter_id]
      traffic_mirror_filters_arguments = { traffic_mirror_filter_ids: [opts[:traffic_mirror_filter_id]] }
    end
    catch_aws_errors do
      resp = @aws.compute_client.describe_traffic_mirror_filters(traffic_mirror_filters_arguments)
      @traffic_mirror_filters = resp.traffic_mirror_filters[0].to_h
      create_resource_methods(@traffic_mirror_filters)
    end
  end

  def traffic_mirror_filter_id
    return unless exists?
    @traffic_mirror_filters[:traffic_mirror_filter_id]
  end

  def exists?
    !@traffic_mirror_filters.nil? && !@traffic_mirror_filters.empty?
  end

  def resource_id
    @traffic_mirror_filters ? @traffic_mirror_filters[:traffic_mirror_filter_id] : @display_name
  end

  def to_s
    "EC2 Traffic Mirror Filter ID: #{@display_name}"
  end
end
