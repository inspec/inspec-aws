require 'aws_backend'

class AwsSsmResourceComplianceSummaries < AwsResourceBase
  name 'aws_ssm_resource_compliance_summaries'
  desc 'Verifies settings for a SSM Resource Compliance Summary in bulk.'
  example "
    describe aws_ssm_resource_compliance_summaries do
      it { should exist }
    end
  "

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:compliance_types,        field: :compliance_type)
             .register_column(:resource_types,          field: :resource_type)
             .register_column(:resource_ids,            field: :resource_id)
             .register_column(:status,                  field: :status)
             .register_column(:overall_severity,        field: :overall_severity)
             .register_column(:execution_summaries,     field: :execution_summary)
             .register_column(:compliant_summaries,     field: :compliant_summary)
             .register_column(:non_compliant_summaries, field: :non_compliant_summary)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(compliance_type overall_severity))
    @table = fetch_data
  end

  def fetch_data
    ssm_resource_compliance_summary_rows = []
    pagination_options = {}

    if opts[:compliance_type] || opts[:overall_severity]
      filter_array = []
      filter_array << { key: 'ComplianceType', values: [opts[:compliance_type]] } if opts[:compliance_type]
      filter_array << { key: 'OverallSeverity', values: [opts[:overall_severity]] } if opts[:overall_severity]
      filter_options = { filters: filter_array }
    end

    loop do
      catch_aws_errors do
        params = filter_options.nil? ? pagination_options : filter_options
        @api_response = @aws.ssm_client.list_resource_compliance_summaries(params)
      end
      return [] if !api_response || api_response.empty?

      api_response.resource_compliance_summary_items.each do |ssm_compliance|
        ssm_resource_compliance_summary_rows += [{ compliance_type:       ssm_compliance.compliance_type,
                                                   resource_type:         ssm_compliance.resource_type,
                                                   resource_id:           ssm_compliance.resource_id,
                                                   status:                ssm_compliance.status,
                                                   overall_severity:      ssm_compliance.overall_severity,
                                                   execution_summary:     ssm_compliance.execution_summary.to_h,
                                                   compliant_summary:     ssm_compliance.compliant_summary.to_h,
                                                   non_compliant_summary: ssm_compliance.non_compliant_summary.to_h }]
      end
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = ssm_resource_compliance_summary_rows
  end
end
