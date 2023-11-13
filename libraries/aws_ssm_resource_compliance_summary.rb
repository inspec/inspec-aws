require 'aws_backend'

class AwsSsmResourceComplianceSummary < AwsResourceBase
  name 'aws_ssm_resource_compliance_summary'
  desc 'Verifies settings for a SSM Resource Compliance Summary.'

  example "
    describe aws_ssm_resource_compliance_summary(resource_id: 'resource-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { resource_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:resource_id], allow: %i(compliance_type overall_severity status))
    @display_name = opts[:resource_id]

    filter_params = [{ key: 'InstanceId', values: [opts[:resource_id]] }]
    filter_params << { key: 'ComplianceType', values: [opts[:compliance_type]] } if opts[:compliance_type]
    filter_params << { key: 'OverallSeverity', values: [opts[:overall_severity]] } if opts[:overall_severity]
    filter_params << { key: 'Status', values: [opts[:status]] } if opts[:status]

    filter = { filters: filter_params }

    catch_aws_errors do
      resp = @aws.ssm_client.list_resource_compliance_summaries(filter)
      if resp.resource_compliance_summary_items.first.nil?
        empty_response_warn
      else
        @compliance_summary = resp.resource_compliance_summary_items.first.to_h
        create_resource_methods(@compliance_summary)
      end
    end
  end

  def resource_id
    @res? @compliance_summary[:resource_id]: @display_name
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
