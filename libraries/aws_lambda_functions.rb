# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaFunctions < AwsResourceBase
  name 'aws_lambda_functions'
  desc 'List all the functions.'

  example "
    describe aws_lambda_functions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:function_names,                                  field: :function_name)
             .register_column(:function_arns,                                   field: :function_arn)
             .register_column(:runtimes,                                        field: :runtime)
             .register_column(:roles,                                           field: :role)
             .register_column(:handlers,                                        field: :handler)
             .register_column(:code_sizes,                                      field: :code_size)
             .register_column(:descriptions,                                    field: :description)
             .register_column(:timeouts,                                        field: :timeout)
             .register_column(:memory_sizes,                                    field: :memory_size)
             .register_column(:last_modified,                                   field: :last_modified)
             .register_column(:code_sha_256,                                    field: :code_sha_256)
             .register_column(:versions,                                        field: :version)
             .register_column(:vpc_configs,                                     field: :vpc_config)
             .register_column(:dead_letter_configs,                             field: :dead_letter_config)
             .register_column(:environments,                                    field: :environment)
             .register_column(:kms_key_arns,                                    field: :kms_key_arn)
             .register_column(:tracing_configs,                                 field: :tracing_config)
             .register_column(:master_arns,                                     field: :master_arn)
             .register_column(:revision_ids,                                    field: :revision_id)
             .register_column(:layers,                                          field: :layers)
             .register_column(:states,                                          field: :state)
             .register_column(:state_reasons,                                   field: :state_reason)
             .register_column(:state_reason_codes,                              field: :state_reason_code)
             .register_column(:last_update_statuses,                            field: :last_update_status)
             .register_column(:last_update_status_reasons,                      field: :last_update_status_reason)
             .register_column(:last_update_status_reason_codes,                 field: :last_update_status_reason_code)
             .register_column(:file_system_configs,                             field: :file_system_configs)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_items] = 10
    loop do
      catch_aws_errors do
        @api_response = @aws.lambda_client.list_functions(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.functions.each do |resp|
        rows += [{ function_name: resp.function_name,
                   function_arn: resp.function_arn,
                   runtime: resp.runtime,
                   role: resp.role,
                   handler: resp.handler,
                   code_size: resp.code_size,
                   description: resp.description,
                   timeout: resp.timeout,
                   memory_size: resp.memory_size,
                   last_modified: resp.last_modified,
                   code_sha_256: resp.code_sha_256,
                   version: resp.version,
                   vpc_config: resp.vpc_config,
                   dead_letter_config: resp.dead_letter_config,
                   environment: resp.environment,
                   kms_key_arn: resp.kms_key_arn,
                   tracing_config: resp.tracing_config,
                   master_arn: resp.master_arn,
                   revision_id: resp.revision_id,
                   layers: resp.layers,
                   state: resp.state,
                   state_reason: resp.state_reason,
                   state_reason_code: resp.state_reason_code,
                   last_update_status: resp.last_update_status,
                   last_update_status_reason: resp.last_update_status_reason,
                   last_update_status_reason_code: resp.last_update_status_reason_code,
                   file_system_configs: resp.file_system_configs  }]
      end
      break unless @api_response.next_marker
      pagination_options[:marker] = @api_response.next_marker
    end
    rows
  end
end
