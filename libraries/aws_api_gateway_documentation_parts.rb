# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayDocumentationParts < AwsResourceBase
  name 'aws_api_gateway_documentation_parts'
  desc 'Lists the patch baselines in your Amazon Web Services account.'

  example "
    describe aws_api_gateway_documentation_parts do
      it { should exist }
    end
    describe aws_api_gateway_documentation_parts do
      its('ids') { should include DOCUMENTATION_PART_ID' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:types, field: :type)
             .register_column(:paths, field: :path)
             .register_column(:methods, field: :method)
             .register_column(:status_codes, field: :status_code)
             .register_column(:names, field: :name)
             .register_column(:properties, field: :properties)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.ssm_client.get_documentation_parts.map do |table|
        table.baseline_identities.map { |table_name| {
          ids: table_name.baseline_id,
          baseline_name: table_name.baseline_name,
          operating_system: table_name.operating_system,
          baseline_description: table_name.baseline_description,
          default_baseline: table_name.default_baseline,
          baseline_description: table_name.baseline_description,
          default_baseline: table_name.default_baseline,
        }
        }
      end.flatten
    end
  end
end