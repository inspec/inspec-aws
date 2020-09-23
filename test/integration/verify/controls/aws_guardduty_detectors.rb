title 'Test AWS GuardDuty Detectors in bulk'

aws_guardduty_detector_id = attribute(:aws_guardduty_detector_id, default: '', description: 'The AWS GuardDuty Detector ID.')
aws_guardduty_detector_publishing_frequency = attribute(:aws_guardduty_detector_publishing_frequency,
                                                        default: '',
                                                        description: 'The AWS GuardDuty Detector ID.')

control 'aws-guardduty-detectors-1.0' do

  impact 1.0
  title 'Ensure AWS GuardDuty Detector has current properties'

  describe aws_guardduty_detectors do
    it                  { should exist }
    its('detector_ids') { should include [aws_guardduty_detector_id] }
  end

  aws_guardduty_detectors.detector_ids.first.each do |detector_id|
    describe aws_guardduty_detector(detector_id: detector_id) do
      it { should exist }
      its('finding_publishing_frequency') { should eq aws_guardduty_detector_publishing_frequency }
    end
  end
end
