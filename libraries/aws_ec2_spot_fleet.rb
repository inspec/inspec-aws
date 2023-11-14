require "aws_backend"

class AWSEC2SpotFleet < AwsResourceBase
  name "aws_ec2_spot_fleet"
  desc "Describes your Spot Fleet requests."

  example "
    describe aws_ec2_spot_fleet(spot_fleet_request_id: 'SpotFleetRequestID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { spot_fleet_request_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:spot_fleet_request_id])
    unless opts[:spot_fleet_request_id] && !opts[:spot_fleet_request_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: spot_fleet_request_id must be provided"
    end
    @display_name = opts[:spot_fleet_request_id]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_spot_fleet_requests(
          { spot_fleet_request_ids: [opts[:spot_fleet_request_id]] }
        )
      @res = resp.spot_fleet_request_configs[0].to_h
      create_resource_methods(@res)
    end
  end

  def spot_fleet_request_id
    return nil unless exists?
    @res[:spot_fleet_request_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:spot_fleet_request_id] : @display_name
  end

  def to_s
    "Spot Fleet Request ID: #{@display_name}"
  end
end
