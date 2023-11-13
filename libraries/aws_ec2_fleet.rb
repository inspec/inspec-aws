require "aws_backend"

class AWSEC2Fleet < AwsResourceBase
  name "aws_ec2_fleet"
  desc "Describes the specified EC2 Fleets or all of your EC2 Fleets."

  example "
    describe aws_ec2_fleet(fleet_id: 'FLEET_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { fleet_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:fleet_id])
    raise ArgumentError, "#{@__resource_name__}: fleet_id must be provided" unless opts[:fleet_id] && !opts[:fleet_id].empty?
    @display_name = opts[:fleet_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_fleets({ fleet_ids: [opts[:fleet_id]] })
      @resp = resp.fleets[0].to_h
      create_resource_methods(@resp)
    end
  end

  def fleet_id
    return unless exists?
    @resp[:fleet_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @resp ? @resp[:fleet_id] : @display_name
  end

  def to_s
    "Fleet Id: #{@display_name}"
  end
end
