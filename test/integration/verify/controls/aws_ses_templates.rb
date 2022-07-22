aws_ses_template_name = input(:aws_ses_template_name, value: '', description: '')

control 'aws-ses-templates-1.0' do
  impact 1.0
  title 'Test the properties of the ses receipt rules.'

  describe aws_ses_templates do
    it { should exist }
  end

  describe aws_ses_templates do
    its('names') { should include aws_ses_template_name }
    its('created_timestamps') { should_not be_empty }
  end
end
