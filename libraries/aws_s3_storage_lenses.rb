# frozen_string_literal: true

require 'aws_backend'

class AWSS3StorageLenses < AwsResourceBase
  name 'aws_s3_storage_lenses'
  desc 'Returns information about S3 Storage lens.'

  example "
    describe aws_s3_storage_lenses(account_id: 'ACCOUNT_ID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:storage_lens_arns, field: :storage_lens_arn)
             .register_column(:home_regions, field: :home_region)
             .register_column(:is_enabled, field: :is_enabled)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(account_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: account_id must be provided" unless opts[:account_id] && !opts[:account_id].empty?
    @query_params[:account_id] = opts[:account_id]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.s3control_client.list_storage_lens_configurations(@query_params).map do |table|
        table.storage_lens_configuration_list.map { |table_name| {
          id: table_name.id,
          storage_lens_arn: table_name.storage_lens_arn,
          home_region: table_name.home_region,
          is_enabled: table_name.is_enabled,
        }
        }
      end.flatten
    end
  end
end
