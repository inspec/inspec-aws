require 'aws_backend'

class AwsAutoScalingGroups < AwsResourceBase
  name 'aws_auto_scaling_groups'
  desc 'Verifies settings for a collection AWS Auto Scaling Groups.'

  example "
    describe aws_auto_scaling_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:names,                      field: :name)
             .register_column(:min_sizes,                  field: :min_size)
             .register_column(:max_sizes,                  field: :max_size)
             .register_column(:desired_capacities,         field: :desired_capacity)
             .register_column(:vpc_zone_identifiers,       field: :vpc_zone_identifier)
             .register_column(:launch_configuration_names, field: :launch_configuration_name)
             .register_column(:health_check_types,         field: :health_check_type)
             .register_column(:tags,                       field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    config_rows = []
    catch_aws_errors do
      response = @aws.service_client.describe_auto_scaling_groups
      return [] if !response || response.empty?
      response.auto_scaling_groups.each do |group|
        config_rows += [{ name:                     group[:auto_scaling_group_name],
                         min_size:                  group[:min_size].to_i,
                         max_size:                  group[:max_size].to_i,
                         desired_capacity:          group[:desired_capacity].to_i,
                         vpc_zone_identifier:       group[:vpc_zone_identifier].split(','),
                         launch_configuration_name: group[:launch_configuration_name],
                         health_check_type:         group[:health_check_type],
                         tags:                      group[:tags].map { |tag|
                                                      {
                                                        'resource_id':          tag.resource_id,
                                                        'resource_type':        tag.resource_type,
                                                        'key':                  tag.key,
                                                        'value':                tag.value,
                                                        'propagate_at_launch':  tag.propagate_at_launch,
                                                      }
                                                    } }]

      end
    end
    @table = config_rows
  end
end
