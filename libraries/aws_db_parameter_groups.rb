require 'aws_backend'

class AwsDbParameterGroups < AwsResourceBase
  name 'aws_db_parameter_groups'
  desc 'Verifies settings for a Parameter Group in bulk.'
  example <<-EXAMPLE
    describe aws_db_parameter_groups do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:db_parameter_group_names,                field: :db_parameter_group_name)
             .register_column(:db_parameter_group_families,             field: :db_parameter_group_family)
             .register_column(:descriptions,                            field: :description)
             .register_column(:db_parameter_group_arns,                 field: :db_parameter_group_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    parameter_group_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_parameter_groups(pagination_options)
      end
      return parameter_group_rows if !api_response || api_response.empty?
      parameter_group_rows += api_response.db_parameter_groups.map(&:to_h)
      break unless api_response.marker
      pagination_options = { marker: api_response[:marker] }
    end
    @table = parameter_group_rows
  end
end
