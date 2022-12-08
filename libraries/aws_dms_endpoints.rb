require "aws_backend"

class AWSDMSEndpoints < AwsResourceBase
  name "aws_dms_endpoints"
  desc "Returns information about the endpoints for your account in the current region."

  example "
    describe aws_dms_endpoints do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:endpoint_identifiers,                field: :endpoint_identifier)
    .register_column(:endpoint_types,                      field: :endpoint_type)
    .register_column(:engine_names,                        field: :engine_name)
    .register_column(:engine_display_names,                field: :engine_display_name)
    .register_column(:usernames,                           field: :username)
    .register_column(:server_names,                        field: :server_name)
    .register_column(:ports,                               field: :port)
    .register_column(:database_names,                      field: :database_name)
    .register_column(:extra_connection_attributes,         field: :extra_connection_attributes)
    .register_column(:statuses,                            field: :status)
    .register_column(:kms_key_ids,                         field: :kms_key_id)
    .register_column(:endpoint_arns,                       field: :endpoint_arn)
    .register_column(:certificate_arns,                    field: :certificate_arn)
    .register_column(:ssl_modes,                           field: :ssl_mode)
    .register_column(:service_access_role_arns,            field: :service_access_role_arn)
    .register_column(:external_table_definitions,          field: :external_table_definition)
    .register_column(:external_ids,                        field: :external_id)
    .register_column(:dynamo_db_settings,                  field: :dynamo_db_settings)
    .register_column(:s3_settings,                         field: :s3_settings)
    .register_column(:dms_transfer_settings,               field: :dms_transfer_settings)
    .register_column(:mongo_db_settings,                   field: :mongo_db_settings)
    .register_column(:kinesis_settings,                    field: :kinesis_settings)
    .register_column(:kafka_settings,                      field: :kafka_settings)
    .register_column(:elasticsearch_settings,              field: :elasticsearch_settings)
    .register_column(:neptune_settings,                    field: :neptune_settings)
    .register_column(:redshift_settings,                   field: :redshift_settings)
    .register_column(:postgre_sql_settings,                field: :postgre_sql_settings)
    .register_column(:my_sql_settings,                     field: :my_sql_settings)
    .register_column(:oracle_settings,                     field: :oracle_settings)
    .register_column(:sybase_settings,                     field: :sybase_settings)
    .register_column(:microsoft_sql_server_settings,       field: :microsoft_sql_server_settings)
    .register_column(:ibm_db_2_settings,                   field: :ibm_db_2_settings)
    .register_column(:doc_db_settings,                     field: :doc_db_settings)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    table_rows = []
    query_params = {}
    query_params[:max_records] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.dmsmigrationservice_client.describe_endpoints(query_params)
      end
      return table_rows if !@api_response || @api_response.empty?
      @api_response.endpoints.each do |res|
        table_rows += [{ endpoint_identifier: res.endpoint_identifier, endpoint_type: res.endpoint_type,
                         engine_name: res.engine_name, engine_display_name: res.engine_display_name,
                         username: res.username,
                         server_name: res.server_name,
                         port: res.port,
                         database_name: res.database_name,
                         extra_connection_attributes: res.extra_connection_attributes,
                         status: res.status,
                         kms_key_id: res.kms_key_id,
                         endpoint_arn: res.endpoint_arn,
                         certificate_arn: res.certificate_arn,
                         ssl_mode: res.ssl_mode,
                         service_access_role_arn: res.service_access_role_arn,
                         external_table_definition: res.external_table_definition,
                         external_id: res.external_id,
                         dynamo_db_settings: res.dynamo_db_settings,
                         s3_settings: res.s3_settings,
                         dms_transfer_settings: res.dms_transfer_settings,
                         mongo_db_settings: res.mongo_db_settings,
                         kinesis_settings: res.kinesis_settings,
                         kafka_settings: res.kafka_settings,
                         elasticsearch_settings: res.elasticsearch_settings,
                         neptune_settings: res.neptune_settings,
                         redshift_settings: res.redshift_settings,
                         postgre_sql_settings: res.postgre_sql_settings,
                         my_sql_settings: res.my_sql_settings,
                         oracle_settings: res.oracle_settings,
                         sybase_settings: res.sybase_settings,
                         microsoft_sql_server_settings: res.microsoft_sql_server_settings,
                         ibm_db_2_settings: res.ibm_db_2_settings,
                         doc_db_settings: res.doc_db_settings }]
      end
      break unless @api_response.marker
      query_params[:marker] = @api_response.marker
    end
    table_rows
  end
end
