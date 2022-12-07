require 'aws_backend'

class AWSEC2PlacementGroups < AwsResourceBase
  name 'aws_ec2_placement_groups'
  desc 'Describes the specified placement groups or all of your placement groups.'

  example "
    describe aws_ec2_placement_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:group_names, field: :group_name)
             .register_column(:states, field: :state)
             .register_column(:strategies, field: :strategy)
             .register_column(:partition_counts, field: :partition_count)
             .register_column(:group_ids, field: :group_id)
             .register_column(:tags, field: :tags)
             .register_column(:availability_zones, field: :availability_zone)
             .register_column(:tenancies, field: :tenancy)
             .register_column(:total_instance_counts, field: :total_instance_count)
             .register_column(:available_instance_counts, field: :available_instance_count)
             .register_column(:ebs_optimized, field: :ebs_optimized)
             .register_column(:ephemeral_storages, field: :ephemeral_storage)
             .register_column(:states, field: :state)
             .register_column(:start_dates, field: :start_date)
             .register_column(:end_dates, field: :end_date)
             .register_column(:end_date_types, field: :end_date_type)
             .register_column(:instance_match_criterias, field: :instance_match_criteria)
             .register_column(:create_dates, field: :create_date)
             .register_column(:tags, field: :tags)
             .register_column(:outpost_arns, field: :outpost_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.compute_client.describe_placement_groups
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.placement_groups.map(&:to_h)
  end
end
