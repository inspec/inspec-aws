require 'aws_backend'

class AwsRedshiftClusterParameterGroups < AwsResourceBase
  name 'aws_redshift_cluster_parameter_groups'
  desc 'Describes a parameter group.'
  example "
    describe aws_redshift_cluster_parameter_groups do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:parameter_group_names,         field: :parameter_group_name)
             .register_column(:parameter_group_families,      field: :parameter_group_family)
             .register_column(:descriptions,                  field: :description)
             .register_column(:tags,                          field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @parameter_groups = @aws.redshift_client.describe_cluster_parameter_groups
    end
    return [] if !@parameter_groups || @parameter_groups.empty?
    @table = @parameter_groups.parameter_groups.map(&:to_h)
  end
end
