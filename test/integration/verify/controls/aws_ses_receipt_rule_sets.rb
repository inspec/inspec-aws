aws_ses_receipt_rule_set_name = input(:aws_ses_receipt_rule_set_name, value: '', description: '')

control 'aws-ses-receipt-rule-sets-1.0' do
  title 'Test the properties of the ses receipt rules.'

  describe aws_ses_receipt_rule_sets do
    it { should exist }
  end

  describe aws_ses_receipt_rule_sets do
    its('names') { should include aws_ses_receipt_rule_set_name }
    its('created_timestamps') { should_not be_empty }
  end
end
