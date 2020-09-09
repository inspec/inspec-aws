title 'Test AWS GuardDuty Detector in bulk'

aws_guardduty_detector_id = attribute(:aws_guardduty_detector_id, default: '', description: 'The AWS GuardDuty Detector ID.')

control 'aws-guardduty-detector-1.0' do

  impact 1.0
  title 'Ensure AWS GuardDuty Detector has current properties'

  describe aws_guardduty_detector(detector_id: aws_guardduty_detector_id) do
    it { should exist }
  end

  describe aws_guardduty_detector(detector_id: '00000') do
    it { should_not exist }
  end

end
