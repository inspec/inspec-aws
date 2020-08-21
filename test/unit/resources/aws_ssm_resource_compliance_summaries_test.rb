require 'helper'
require 'aws_ssm_resource_compliance_summaries'
require 'aws-sdk-ssm'

class AwsSsmResourceComplianceSummariesConstructorTest < Minitest::Test
  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSsmResourceComplianceSummaries.new('rubbish') }
  end
end

class AwsSsmResourceComplianceSummariesSuccessPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :list_resource_compliance_summaries
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
    data[:data] = { resource_compliance_summary_items: [mock_ssm_compliance_summary] }
    data[:client] = Aws::SSM::Client
    @ssm_resource_compliance_items = AwsSsmResourceComplianceSummaries.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_compliance_summary_exists
    assert @ssm_resource_compliance_items.exists?
  end

  def test_ssm_compliance_type
    assert_equal(@ssm_resource_compliance_items.compliance_types, ['FleetTotal'])
  end

  def test_ssm_resource_type
    assert_equal(@ssm_resource_compliance_items.resource_types, ['ManagedInstance'])
  end

  def test_ssm_resource_id
    assert_equal(@ssm_resource_compliance_items.resource_ids, ['mi-0432097523634'])
  end

  def test_ssm_status
    assert_equal(@ssm_resource_compliance_items.status, ['COMPLIANT'])
  end
end

class AwsSsmResourceComplianceSummariesFilterTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :list_resource_compliance_summaries
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
    data[:data] = { resource_compliance_summary_items: [mock_ssm_compliance_summary] }
    data[:client] = Aws::SSM::Client
    @ssm_resource_compliance_items = AwsSsmResourceComplianceSummaries.new(compliance_type: 'FleetTotal', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_compliance_summary_exists
    assert @ssm_resource_compliance_items.exists?
  end

  def test_ssm_compliance_type
    assert_equal(@ssm_resource_compliance_items.compliance_types, ['FleetTotal'])
  end

  def test_ssm_resource_type
    assert_equal(@ssm_resource_compliance_items.resource_types, ['ManagedInstance'])
  end

  def test_ssm_resource_id
    assert_equal(@ssm_resource_compliance_items.resource_ids, ['mi-0432097523634'])
  end

  def test_ssm_status
    assert_equal(@ssm_resource_compliance_items.status, ['COMPLIANT'])
  end
end

