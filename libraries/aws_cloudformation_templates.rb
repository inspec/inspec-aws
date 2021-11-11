# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationTemplates < AwsResourceBase
  name 'aws_cloudformation_templates'
  desc 'Returns information about a new or existing template.'

  example "
    describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      it { should exist }
    end
    describe aws_cloudformation_templates(stack_set_name: 'STACK_SET_NAME') do
      it { should exist }
    end
    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      it { should exist }
    end
    describe aws_cloudformation_templates(template_body: 'TEMPLATE_BODY') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:parameters, field: :parameters)
             .register_column(:descriptions, field: :description)
             .register_column(:capabilities, field: :capabilities)
             .register_column(:capabilities_reasons, field: :capabilities_reason)
             .register_column(:resource_types, field: :resource_types)
             .register_column(:versions, field: :version)
             .register_column(:metadata, field: :metadata)
             .register_column(:declared_transforms, field: :declared_transforms)
             .register_column(:resource_identifier_summaries, field: :resource_identifier_summaries)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(stack_name stack_set_name template_url template_body))
    @query_params = opts.slice(:stack_name, :stack_set_name, :template_url, :template_body)
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudformation_client.get_template_summary(@query_params).map do |table|
        table.map { |table_name| {
          parameters: table_name.parameters,
          description: table_name.description,
          capabilities: table_name.capabilities,
          capabilities_reason: table_name.capabilities_reason,
          resource_types: table_name.resource_types,
          version: table_name.version,
          metadata: table_name.metadata,
          declared_transforms: table_name.declared_transforms,
          resource_identifier_summaries: table_name.resource_identifier_summaries,
        }
        }
      end.flatten
    end
  end
end
