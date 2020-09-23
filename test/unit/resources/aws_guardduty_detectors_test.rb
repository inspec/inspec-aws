require 'helper'
require 'aws_guardduty_detectors'

class AwsGuardDutyDetectorsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsGuardDutyDetectors.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsGuardDutyDetectors.new('rubbish') }
  end

  def test_detectors_non_existing_for_empty_response
    refute AwsGuardDutyDetectors.new(client_args: { stub_responses: true }).exist?
  end

end

class AwsGuardDutyDetectorsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_detectors
    mock_subnet = {}
    mock_subnet[:detector_ids] = ['id-4332', 'id-4643']
    data[:data] = mock_subnet
    data[:client] = Aws::GuardDuty::Client
    @detectors = AwsGuardDutyDetectors.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_detectors_exist
    assert @detectors.exist?
  end

  def test_detector_ids
    assert_equal(@detectors.detector_ids, [['id-4332', 'id-4643']])
  end
end