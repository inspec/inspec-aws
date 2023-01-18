require "aws_backend"

class AWSSecretsManagerSecrets < AwsResourceBase
  name "aws_secretsmanager_secrets"
  desc "Lists all of the secrets that are stored by Secrets Manager in the AWS account."

  example "
    describe aws_secretsmanager_secrets do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns,                                    field: :arn)
    .register_column(:names,                                   field: :name)
    .register_column(:descriptions,                            field: :description)
    .register_column(:kms_key_ids,                             field: :kms_key_id)
    .register_column(:rotation_enableds,                       field: :rotation_enabled)
    .register_column(:rotation_lambda_arns,                    field: :rotation_lambda_arn)
    .register_column(:rotation_rules,                          field: :rotation_rules)
    .register_column(:last_rotated_dates,                      field: :last_rotated_date)
    .register_column(:last_changed_dates,                      field: :last_changed_date)
    .register_column(:last_accessed_dates,                     field: :last_accessed_date)
    .register_column(:deleted_dates,                           field: :deleted_date)
    .register_column(:tags,                                    field: :tags)
    .register_column(:secret_versions_to_stages,               field: :secret_versions_to_stages)
    .register_column(:owning_services,                         field: :owning_service)
    .register_column(:created_dates,                           field: :created_date)
    .register_column(:primary_regions,                         field: :primary_region)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @query_params = {}
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.secretsmanager_client.list_secrets(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.secret_list.each do |res|
        rows += [{
          arn: res.arn,
          name: res.name,
          description: res.description,
          kms_key_id: res.kms_key_id,
          rotation_enabled: res.rotation_enabled,
          rotation_lambda_arn: res.rotation_lambda_arn,
          rotation_rules: res.rotation_rules,
          last_rotated_date: res.last_rotated_date,
          last_changed_date: res.last_changed_date,
          last_accessed_date: res.last_accessed_date,
          deleted_date: res.deleted_date,
          tags: res.tags,
          owning_service: res.owning_service,
          created_date: res.created_date,
          primary_region: res.primary_region,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
