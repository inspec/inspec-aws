require 'helper'
require 'aws_ssm_resource_compliance_summary'
require 'aws-sdk-ssm'

class AwsSsmResourceComplianceSummaryConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSsmResourceComplianceSummary.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSsmResourceComplianceSummary.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSsmResourceComplianceSummary.new(unexpected: 9) }
  end

end

class AwsSsmResourceComplianceSummarySuccessPathTest < Minitest::Test
  def setup
    compliance_data = []
    summary_data = {}
    summary_data[:method] = :list_resource_compliance_summaries
    mock_ssm_compliance_summary = {}
    mock_ssm_compliance_summary[:compliance_type] = "FleetTotal"
    mock_ssm_compliance_summary[:resource_type] = "ManagedInstance"
    mock_ssm_compliance_summary[:resource_id] = "mi-0432097523634"
    mock_ssm_compliance_summary[:status] = "COMPLIANT"
    mock_ssm_compliance_summary[:execution_summary] = { execution_time: Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")}
    mock_ssm_compliance_summary[:compliant_summary] = { compliant_count: 1,
                                                      severity_summary: { critical_count: 1,
                                                                          high_count: 0,
                                                                          medium_count: 0,
                                                                          low_count: 0,
                                                                          informational_count: 0,
                                                                          unspecified_count: 0 } }
    mock_ssm_compliance_summary[:non_compliant_summary] = { non_compliant_count: 1,
                                                          severity_summary: { critical_count: 0,
                                                                              high_count: 0,
                                                                              medium_count: 0,
                                                                              low_count: 0,
                                                                              informational_count: 0,
                                                                              unspecified_count: 0 } }
    summary_data[:data] = { resource_compliance_summary_items: [mock_ssm_compliance_summary] }
    summary_data[:client] = Aws::SSM::Client
    compliance_data += [summary_data]

    item_data = {}
    item_data[:method] = :list_compliance_items
    mock_ssm_compliance_items = {}
    mock_ssm_compliance_items[:compliance_type] = "FleetTotal"
    mock_ssm_compliance_items[:resource_type] = "ManagedInstance"
    mock_ssm_compliance_items[:resource_id] = "mi-0432097523634"
    mock_ssm_compliance_items[:id] = "version_2.0"
    mock_ssm_compliance_items[:title] = "ScanHost"
    mock_ssm_compliance_items[:status] = "COMPLIANT"
    mock_ssm_compliance_items[:severity] = "CRITICAL"
    mock_ssm_compliance_items[:execution_summary] = { execution_time: Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")}
    mock_ssm_compliance_items[:details] = {}
    item_data[:data] = { compliance_items: [mock_ssm_compliance_items] }
    item_data[:client] = Aws::SSM::Client
    compliance_data += [item_data]

    @ssm_compliance_summary_items = AwsSsmResourceComplianceSummary.new(resource_id: 'mi-0432097523634', client_args: { stub_responses: true }, stub_data: compliance_data)
  end

  def test_ssm_compliance_summary
    assert @ssm_compliance_summary_items.exists?
  end

  def test_ssm_compliance_summary_compliance_type
    assert_equal(@ssm_compliance_summary_items.compliance_type, ['FleetTotal'])
  end

  def test_ssm_compliance_summary_resource_type
    assert_equal(@ssm_compliance_summary_items.resource_type, ['ManagedInstance'])
  end

  def test_ssm_compliance_summary_id
    assert_equal(@ssm_compliance_summary_items.resource_id, ['mi-0432097523634'])
  end

  def test_ssm_compliance_summary_status
    assert_equal(@ssm_compliance_summary_items.status, ['COMPLIANT'])
  end

  def test_ssm_compliance_item_title
    assert_equal(@ssm_compliance_summary_items.compliance_item.first[:title], 'ScanHost')
  end

  def test_ssm_compliance_item_severity
    assert_equal(@ssm_compliance_summary_items.compliance_item.first[:severity], 'CRITICAL')
  end

  def test_ssm_compliance_item_id
    assert_equal(@ssm_compliance_summary_items.compliance_item.first[:id], 'version_2.0')
  end
end