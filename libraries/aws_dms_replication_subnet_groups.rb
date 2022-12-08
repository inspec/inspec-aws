require "aws_backend"

class AWSDMSReplicationSubnetGroups < AwsResourceBase
  name "aws_dms_replication_subnet_groups"
  desc "Returns information about the replication subnet groups."

  example "
    describe aws_dms_replication_subnet_groups do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:replication_subnet_group_identifiers,            field: :replication_subnet_group_identifier)
    .register_column(:replication_subnet_group_descriptions,           field: :replication_subnet_group_description)
    .register_column(:vpc_ids,                                         field: :vpc_id)
    .register_column(:subnet_group_statuses,                           field: :subnet_group_status)
    .register_column(:subnets,                                         field: :subnets)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.dmsmigrationservice_client.describe_replication_subnet_groups
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.replication_subnet_groups.map(&:to_h)
  end
end
