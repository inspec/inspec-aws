require "aws_backend"

class AwsSsmDocuments < AwsResourceBase
  name "aws_ssm_documents"
  desc "Verifies settings for a SSM Document in bulk."
  example "
    describe aws_ssm_documents do
      it { should exist }
    end
  "

  attr_reader :table, :api_response

  FilterTable.create
    .register_column(:names,             field: :name)
    .register_column(:owners,            field: :owner)
    .register_column(:platform_types,    field: :platform_types)
    .register_column(:document_versions, field: :document_version)
    .register_column(:document_types,    field: :document_type)
    .register_column(:schema_versions,   field: :schema_version)
    .register_column(:document_formats,  field: :document_format)
    .register_column(:target_types,      field: :target_type)
    .register_column(:tags,              field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    ssm_document_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.ssm_client.list_documents(pagination_options)
      end
      return ssm_document_rows if !api_response || api_response.empty?

      api_response.document_identifiers.each do |ssm_document|
        ssm_document_rows += [{ name:             ssm_document.name,
                                owner:            ssm_document.owner,
                                platform_types:   ssm_document.platform_types,
                                document_version: ssm_document.document_version,
                                document_type:    ssm_document.document_type,
                                schema_version:   ssm_document.schema_version,
                                document_format:  ssm_document.document_format,
                                target_type:      ssm_document.target_type,
                                tags:             ssm_document.tags }]
      end
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = ssm_document_rows
  end
end
