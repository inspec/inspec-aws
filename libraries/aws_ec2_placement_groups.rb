# frozen_string_literal: true

require 'aws_backend'

class AWSEC2PlacementGroups < AwsResourceBase
  name 'aws_ec2_placement_groups'
  desc 'Audits Placement Groups'

  example "
    describe aws_ec2_placement_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:group_names, field: :group_name)
             .register_column(:strategies, field: :strategy)
             .register_column(:partition_counts, field: :partition_count)
             .register_column(:group_ids, field: :group_id)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp =@aws.compute_client.describe_placement_groups
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.placement_groups.map(&:to_h)
  end
end
