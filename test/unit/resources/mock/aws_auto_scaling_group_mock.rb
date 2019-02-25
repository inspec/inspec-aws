require_relative 'aws_base_resource_mock'

class AwsAutoScalingGroupMock < AwsBaseResourceMock

  def initialize
    super
    @auto_scaling_groups = {auto_scaling_groups: [{auto_scaling_group_name: @aws.any_string,
                                                   min_size: @aws.any_int,
                                                   max_size: @aws.any_int,
                                                   desired_capacity: @aws.any_int,
                                                   vpc_zone_identifier: @aws.any_string,
                                                   launch_configuration_name: @aws.any_string,
                                                   tags: [{resource_id: @aws.any_string,
                                                          resource_type: @aws.any_string,
                                                          key: @aws.any_string,
                                                          value: @aws.any_string,
                                                          propagate_at_launch: true }],
                                                   health_check_type: @aws.any_string,
                                                   default_cooldown: 1,
                                                   availability_zones: [],
                                                   created_time: @aws.any_date}]}
  end

  def stub_data
    stub_data = []

    group = {:client => Aws::AutoScaling::Client,
              :method => :describe_auto_scaling_groups,
              :data => @auto_scaling_groups}

    stub_data += [group]
  end

  def auto_scaling_group
    @auto_scaling_groups
  end
end