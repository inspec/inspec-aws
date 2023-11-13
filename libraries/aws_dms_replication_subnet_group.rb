require "aws_backend"

class AWSDMSReplicationSubnetGroup < AwsResourceBase
  name "aws_dms_replication_subnet_group"
  desc "Returns information about the replication subnet groups."
  example <<-EXAMPLE
    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'REPLICATION_SUBNET_GROUP_IDENTIFIER') do
      it { should exits }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { replication_subnet_group_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:replication_subnet_group_identifier])
    raise ArgumentError, "#{@__resource_name__}: replication_subnet_group_identifier must be provided" unless opts[:replication_subnet_group_identifier] && !opts[:replication_subnet_group_identifier].empty?
    @display_name = opts[:replication_subnet_group_identifier]
    catch_aws_errors do
      resp = @aws.dmsmigrationservice_client.describe_replication_subnet_groups(
        {
          filters: [
            {
              name: "replication-subnet-group-id",
              values: [opts[:replication_subnet_group_identifier]],
            },
          ],
        },
      )
      @replication_subnet_groups = resp.replication_subnet_groups[0].to_h
      create_resource_methods(@replication_subnet_groups)
    end
  end

  def resource_id
    @display_name
  end

  def replication_subnet_group_identifier
    return unless exists?
    @replication_subnet_groups[:replication_subnet_group_identifier]
  end

  def exists?
    !@replication_subnet_groups.nil? && !@replication_subnet_groups.empty?
  end

  def to_s
    "Replication Subnet Group Identifier Name: #{@display_name}"
  end
end
