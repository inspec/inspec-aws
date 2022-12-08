require "aws_backend"

class AwsAutoScalingGroup < AwsResourceBase
  name "aws_auto_scaling_group"
  desc "Verifies settings for an AWS Auto Scaling Group."

  example "
    describe aws_auto_scaling_group('group-name') do
      it { should exist }
    end
  "

  attr_reader :name, :min_size, :max_size, :desired_capacity, :vpc_zone_identifier,
              :launch_configuration_name, :tags, :health_check_type

  def initialize(opts = {})
    opts = { auto_scaling_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:auto_scaling_group_name])

    catch_aws_errors do
      resp = @aws.service_client.describe_auto_scaling_groups(auto_scaling_group_names: [opts[:auto_scaling_group_name]])
      return nil if resp.auto_scaling_groups.nil? || resp.auto_scaling_groups.empty?
      auto_scaling_group = resp.auto_scaling_groups[0]
      @name                      = auto_scaling_group[:auto_scaling_group_name]
      @min_size                  = auto_scaling_group[:min_size].to_i
      @max_size                  = auto_scaling_group[:max_size].to_i
      @desired_capacity          = auto_scaling_group[:desired_capacity].to_i
      @vpc_zone_identifier       = auto_scaling_group[:vpc_zone_identifier].split(",")
      @launch_configuration_name = auto_scaling_group[:launch_configuration_name]
      @health_check_type         = auto_scaling_group[:health_check_type]
      @tags = []
      @arn = auto_scaling_group[:auto_scaling_group_arn]

      auto_scaling_group[:tags].map { |tag|
        @tags.push(
          {
            'resource_id':              tag.resource_id,
            'resource_type':            tag.resource_type,
            'key':                      tag.key,
            'value':                    tag.value,
            'propagate_at_launch':      tag.propagate_at_launch,
          },
        )
      }
    end
  end

  def exists?
    !@name.nil?
  end

  def resource_id
    @arn
  end

  def to_s
    "AWS Auto Scaling Group #{@name}"
  end
end
