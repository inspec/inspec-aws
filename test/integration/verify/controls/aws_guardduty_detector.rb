title 'Test AWS GuardDuty Detector in bulk'

aws_guardduty_detector_id = input(:aws_guardduty_detector_id, value: '', description: 'The AWS GuardDuty Detector ID.')
aws_guardduty_detector_publishing_frequency = input(:aws_guardduty_detector_publishing_frequency, value: '', description: '')

control 'aws-guardduty-detector-1.0' do
  title 'Ensure AWS GuardDuty Detector has current properties'

  describe aws_guardduty_detector(detector_id: aws_guardduty_detector_id) do
    it { should exist }
    it { should be_enabled }
    its('finding_publishing_frequency') { should eq aws_guardduty_detector_publishing_frequency }
  end

  describe aws_guardduty_detector(detector_id: 'dummy') do
    it { should_not exist }
  end
end
