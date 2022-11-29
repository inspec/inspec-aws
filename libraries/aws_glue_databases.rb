require 'aws_backend'

class AWSGlueDatabases < AwsResourceBase
  name 'aws_glue_databases'
  desc 'Retrieves all databases defined in a given Data Catalog.'

  example "
    describe aws_glue_databases do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:names,                                       field: :name)
             .register_column(:descriptions,                                field: :description)
             .register_column(:location_uris,                               field: :location_uri)
             .register_column(:parameters,                                  field: :parameters)
             .register_column(:create_times,                                field: :create_time)
             .register_column(:create_table_default_permissions,            field: :create_table_default_permissions)
             .register_column(:target_databases,                            field: :target_database)
             .register_column(:catalog_ids,                                 field: :catalog_id)
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
        @api_response = @aws.glue_client.get_databases(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.database_list.each do |res|
        rows += [{
          name: res.name,
          description: res.description,
          location_uri: res.location_uri,
          parameters: res.parameters,
          create_time: res.create_time,
          create_table_default_permissions: res.create_table_default_permissions,
          target_database: res.target_database,
          catalog_id: res.catalog_id,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
