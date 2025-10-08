require "aws_backend"

class AWSEC2PlacementGroup < AwsResourceBase
  name "aws_ec2_placement_group"
  desc "Describes the specified placement groups or all of your placement groups."

  example "
    describe aws_ec2_placement_group(placement_group_name: 'PLACEMENT_GROUP_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { placement_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:placement_group_name])
    unless opts[:placement_group_name] && !opts[:placement_group_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: placement_group_name must be provided"
    end
    @display_name = opts[:placement_group_name]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_placement_groups(
          { group_names: [opts[:placement_group_name]] }
        )
      @resp = resp.placement_groups[0].to_h
      @placement_group_name = resp.placement_groups[0].group_name
      create_resource_methods(@resp)
    end
  end

  def placement_group_name
    return nil unless exists?
    @resp[:group_name]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def resource_id
    @placement_group_name
  end

  def to_s
    "Placement Group Name: #{@display_name}"
  end
end
