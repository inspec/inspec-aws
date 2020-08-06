# frozen_string_literal: true

require 'aws_backend'

class AwsSsmResourceComplianceSummary < AwsResourceBase
  name 'aws_ssm_resource_compliance_summary'
  desc 'Verifies settings for a SSM Resource Compliance Summary'

  example "
    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:compliance_type,       field: :compliance_type)
             .register_column(:resource_type,         field: :resource_type)
             .register_column(:resource_id,           field: :resource_id)
             .register_column(:status,                field: :status)
             .register_column(:overall_severity,      field: :overall_severity)
             .register_column(:execution_summary,     field: :execution_summary)
             .register_column(:compliant_summary,     field: :compliant_summary)
             .register_column(:non_compliant_summary, field: :non_compliant_summary)
             .register_column(:compliance_item,       field: :compliance_item)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    opts = { resource_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:resource_id], allow: %i(compliance_type status))
    @display_name = opts[:resource_id]

    catch_aws_errors do
      @compliance_summaries = return_resource_id_data(compliance_summary_data: @aws.ssm_client.list_resource_compliance_summaries)
      return if @compliance_summaries.empty?

      @compliance_items = @aws.ssm_client.list_compliance_items({ resource_ids: [opts[:resource_id]] }).to_h[:compliance_items]
      append_compliance_item
    end

    @table = return_compliance_summaries
  end

  def return_resource_id_data(compliance_summary_data:)
    compliance_array = compliance_summary_data.to_h[:resource_compliance_summary_items]
    filtered_summary = compliance_array.select { |summary| summary[:resource_id] == opts[:resource_id] }
    filtered_summary = filtered_summary.select { |summary| summary[:compliance_type] == opts[:compliance_type] } if opts[:compliance_type]
    filtered_summary = filtered_summary.select { |summary| summary[:status] == opts[:status] } if opts[:status]
    filtered_summary
  end

  def append_compliance_item
    @compliance_summaries.each do |cs|
      compliance_item = @compliance_items.select { |ci| ci[:compliance_type] == cs[:compliance_type] }.first
      cs[:compliance_item] = compliance_item
    end
  end

  def return_compliance_summaries
    ssm_resource_compliance_summary_rows = []

    @compliance_summaries.each do |ssm_compliance|
      ssm_resource_compliance_summary_rows += [{ compliance_type:       ssm_compliance[:compliance_type],
                                                 resource_type:         ssm_compliance[:resource_type],
                                                 resource_id:           ssm_compliance[:resource_id],
                                                 status:                ssm_compliance[:status],
                                                 overall_severity:      ssm_compliance[:overall_severity],
                                                 execution_summary:     ssm_compliance[:execution_summary],
                                                 compliant_summary:     ssm_compliance[:compliant_summary],
                                                 non_compliant_summary: ssm_compliance[:non_compliant_summary],
                                                 compliance_item:       ssm_compliance[:compliance_item] }]
    end
    @table = ssm_resource_compliance_summary_rows
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Resource ID #{@display_name}"
  end

  def name
    name if exists?
  end
end
