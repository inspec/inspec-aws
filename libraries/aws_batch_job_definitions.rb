require "aws_backend"

class AWSBatchJobDefinitions < AwsResourceBase
  name "aws_batch_job_definitions"
  desc "Describes a list of job definitions."

  example "
    describe aws_batch_job_definitions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:job_definition_names,                    field: :job_definition_name)
    .register_column(:job_definition_arns,                     field: :job_definition_arn)
    .register_column(:revisions,                               field: :revision)
    .register_column(:statuses,                                field: :status)
    .register_column(:types,                                   field: :type)
    .register_column(:parameters,                              field: :parameters)
    .register_column(:tags,                                    field: :tags)
    .register_column(:propagate_tags,                          field: :propagate_tags)
    .register_column(:platform_capabilities,                   field: :platform_capabilities)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    job_definition_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.batch_client.describe_job_definitions(pagination_options)
      end
      return job_definition_rows if !@api_response || @api_response.empty?
      @api_response.job_definitions.each do |job_definition|
        job_definition_rows += [{
          job_definition_name: job_definition.job_definition_name,
          job_definition_arn: job_definition.job_definition_arn,
          revision: job_definition.revision,
          status: job_definition.status,
          type: job_definition.type,
          parameters: job_definition.parameters,
          tags: job_definition.tags,
          propagate_tags: job_definition.propagate_tags,
          platform_capabilities: job_definition.platform_capabilities,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = job_definition_rows
  end
end
