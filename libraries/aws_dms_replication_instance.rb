# frozen_string_literal: true

require 'aws_backend'

class AWSDMSReplicationInstance < AwsResourceBase
  name 'aws_dms_replication_instance'
  desc 'Returns information about the replication instance types that can be created in the specified region.'
  example "
    describe aws_dms_replication_instance do
      it { should exits }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      resp = @aws.dmsmigrationservice_client.describe_orderable_replication_instances
      @orderable_replication_instances = resp.orderable_replication_instances[0].to_h
      create_resource_methods(@orderable_replication_instances)
    end
  end

  def id
    return nil unless exists?
    @orderable_replication_instances[:auto_scaling_group_name]
  end

  def exists?
    !@orderable_replication_instances.nil? && !@orderable_replication_instances.empty?
  end

  def encrypted?
    @orderable_replication_instances[:encrypted]
  end

  def to_s
    "auto_scaling_group_name: #{@display_name}"
  end
end
