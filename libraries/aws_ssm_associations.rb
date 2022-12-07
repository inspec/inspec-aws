require 'aws_backend'

class AwsSsmAssociations < AwsResourceBase
  name 'aws_ssm_associations'
  desc 'Verifies settings for a SSM Association in bulk.'
  example "
    describe aws_ssm_associations do
      it { should exist }
    end
  "

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:names,                field: :name)
             .register_column(:instance_ids,         field: :instance_id)
             .register_column(:association_ids,      field: :association_id)
             .register_column(:association_versions, field: :association_version)
             .register_column(:document_versions,    field: :document_version)
             .register_column(:targets,              field: :targets)
             .register_column(:last_execution_dates, field: :last_execution_date)
             .register_column(:overviews,            field: :overview)
             .register_column(:schedule_expressions, field: :schedule_expression)
             .register_column(:association_names,    field: :association_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    ssm_association_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.ssm_client.list_associations(pagination_options)
      end
      return ssm_association_rows if !api_response || api_response.empty?

      api_response.associations.each do |ssm_association|
        ssm_association_rows += [{ name:                ssm_association.name,
                                   instance_id:         ssm_association.instance_id,
                                   association_id:      ssm_association.association_id,
                                   association_version: ssm_association.association_version,
                                   document_version:    ssm_association.document_version,
                                   targets:             ssm_association.targets,
                                   last_execution_date: ssm_association.last_execution_date,
                                   overview:            ssm_association.overview.to_h,
                                   schedule_expression: ssm_association.schedule_expression,
                                   association_name:    ssm_association.association_name }]
      end
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = ssm_association_rows
  end
end
