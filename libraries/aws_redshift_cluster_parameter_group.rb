# frozen_string_literal: true

require 'aws_backend'

class AwsRedshiftClusterParameterGroup < AwsResourceBase
  name 'aws_redshift_cluster_parameter_group'
  desc 'Describes a parameter group.'
  example "
    describe aws_redshift_cluster_parameter_group(parameter_group_name: aws_parameter_group_name) do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { public_ip: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:parameter_group_name])

    raise ArgumentError, "#{@__resource_name__}: parameter_group_name must be provided" unless opts[:parameter_group_name] && !opts[:parameter_group_name].empty?
    @display_name = opts[:parameter_group_name]
    catch_aws_errors do
      resp = @aws.redshift_client.describe_cluster_parameter_groups({ parameter_group_name: opts[:parameter_group_name] })
      @parameter_groups = resp.parameter_groups[0].to_h
      create_resource_methods(@parameter_groups)
    end
  end

  def parameter_group_name
    return nil unless exists?
    @parameter_groups[:parameter_group_name]
  end

  def exists?
    !@parameter_groups.nil? && !@parameter_groups.empty?
  end

  def to_s
    "Redshift Cluster Parameter Group Name: #{@display_name}"
  end
end
