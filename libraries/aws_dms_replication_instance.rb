# frozen_string_literal: true

require 'aws_backend'

class AWSDMSReplicationInstance < AwsResourceBase
  name 'aws_dms_replication_instance'
  desc 'Returns information about the replication instance types that can be created in the specified region.'

  example "
    describe aws_dms_replication_instance(auto_scaling_group_name: 'test') do
      it { should eq 'test' }
    end

    describe aws_dms_replication_instance(auto_scaling_group_name: 'test') do
      it { should exits }
    end
  "
  def initialize(opts = {})
    opts = { auto_scaling_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:auto_scaling_group_name])

    raise ArgumentError, "#{@__resource_name__}: auto_scaling_group_name must be provided" unless opts[:auto_scaling_group_name] && !opts[:auto_scaling_group_name].empty?
    @display_name = opts[:auto_scaling_group_name]
    catch_aws_errors do
      resp = @aws.dmsmigrationservice_client.describe_orderable_replication_instances({ auto_scaling_group_name: opts[:auto_scaling_group_name] })
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
