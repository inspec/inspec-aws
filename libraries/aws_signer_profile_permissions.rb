require 'aws_backend'

class AWSSignerProfilePermissions < AwsResourceBase
  name 'aws_signer_profile_permissions'
  desc 'Lists the cross-account permissions associated with a signing profile.'

  example "
    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:actions, field: :action)
             .register_column(:principals, field: :principal)
             .register_column(:statement_ids, field: :statement_id)
             .register_column(:profile_versions, field: :profile_version)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(profile_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: profile_name must be provided" unless opts[:profile_name] && !opts[:profile_name].empty?
    @query_params[:profile_name] = opts[:profile_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.signer_client.list_profile_permissions(@query_params).map do |table|
        table.permissions.map { |table_name| {
          action: table_name.action,
          principal: table_name.principal,
          statement_id: table_name.statement_id,
          profile_version: table_name.profile_version,
        }
        }
      end.flatten
    end
  end
end
