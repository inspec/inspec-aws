# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaFunctions < AwsResourceBase
  name 'aws_lambda_functions'
  desc ''
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
             .register_column(:code_sha_256s,                                   field: :code_sha_256)
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
    catch_aws_errors do
      @resp = @aws.lambda_client.list_functions
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.functions.map(&:to_h)
  end
end
