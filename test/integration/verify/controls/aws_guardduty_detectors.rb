title 'Test AWS GuardDuty Detectors in bulk'

aws_guardduty_detector_id = attribute(:aws_guardduty_detector_id, default: '', description: 'The AWS GuardDuty Detector ID.')

control 'aws-guardduty-detectors-1.0' do

  impact 1.0
  title 'Ensure AWS GuardDuty Detector has current properties'

  describe aws_guardduty_detectors do
    it                  { should exist }
    its('detector_ids') { should include [aws_guardduty_detector_id] }
  end
end
