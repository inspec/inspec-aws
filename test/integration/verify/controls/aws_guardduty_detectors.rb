title 'Test AWS GuardDuty Detectors in bulk'

aws_guardduty_detector_id = input(:aws_guardduty_detector_id, value: '', description: 'The AWS GuardDuty Detector ID.')
aws_guardduty_detector_publishing_frequency = input(:aws_guardduty_detector_publishing_frequency, value: '', description: '')

control 'aws-guardduty-detectors-1.0' do
  title 'Ensure AWS GuardDuty Detector has current properties'

  describe aws_guardduty_detectors do
    it { should exist }
    its('detector_ids') { should include [aws_guardduty_detector_id] }
  end

  aws_guardduty_detectors.detector_ids.first.each do |detector_id|
    describe aws_guardduty_detector(detector_id: detector_id) do
      it { should exist }
      its('finding_publishing_frequency') { should eq aws_guardduty_detector_publishing_frequency }
    end
  end
end
