# frozen_string_literal: true

require 'aws_backend'

class AWSDMSReplicationSubnetGroup < AwsResourceBase
  name 'aws_dms_replication_subnet_group'
  desc 'Returns information about the replication subnet groups.'

  example "
    describe aws_dms_replication_subnet_group(auto_scaling_group_name: 'test') do
      it { should eq 'test' }
    end

    describe aws_dms_replication_subnet_group(auto_scaling_group_name: 'test') do
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
      resp = @aws.dmsmigrationservice_client.describe_replication_subnet_groups({ auto_scaling_group_name: opts[:auto_scaling_group_name] })
      @replication_subnet_groups = resp.replication_subnet_groups[0].to_h
      create_resource_methods(@replication_subnet_groups)
    end
  end

  def id
    return nil unless exists?
    @replication_subnet_groups[:auto_scaling_group_name]
  end

  def exists?
    !@replication_subnet_groups.nil? && !@replication_subnet_groups.empty?
  end

  def encrypted?
    @replication_subnet_groups[:encrypted]
  end

  def to_s
    "auto_scaling_group_name: #{@display_name}"
  end
end
