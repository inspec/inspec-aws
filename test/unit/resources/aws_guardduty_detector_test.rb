require 'helper'
require 'aws_guardduty_detector'

class AwsGuarddutyDetectorConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsGuardDutyDetector.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsGuardDutyDetector.new(detector_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsGuardDutyDetector.new(unexpected: 9) }
  end
end

class AwsGuardDutyDetectorSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_detector
    mock_detector = {}
    mock_detector[:created_at] = '2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00'
    mock_detector[:finding_publishing_frequency] = 'SIX_HOURS'
    mock_detector[:service_role] = 'default'
    mock_detector[:status] = 'DetectorStatus'
    mock_detector[:updated_at] = '2014-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00'
    mock_detector[:data_sources] = { cloud_trail: { status: "CloudTrailStatus" },
                                     dns_logs:    { status: "DNSLogsStatus" },
                                     flow_logs:   { status: "FlowLogsStatus" },
                                     s3_logs:     { status: "S3LogsStatus" } }
    data[:data] = mock_detector
    data[:client] = Aws::GuardDuty::Client
    @detector = AwsGuardDutyDetector.new(detector_id: 'default', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_detector_exists
    assert @detector.exists?
  end

  def test_detector_created_at
    assert_equal(@detector.created_at, '2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00')
  end

  def test_detector_publishing_frequency
    assert_equal(@detector.finding_publishing_frequency, 'SIX_HOURS')
  end

  def test_detector_status
    assert_equal(@detector.status, 'DetectorStatus')
  end

  def test_detector_updated_at
    assert_equal(@detector.updated_at, '2014-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00')
  end

end