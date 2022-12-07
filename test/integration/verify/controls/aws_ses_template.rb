aws_ses_template_name = input(:aws_ses_template_name, value: '', description: '')
aws_ses_template_subject = input(:aws_ses_template_subject, value: '', description: '')
aws_ses_template_text = input(:aws_ses_template_text, value: '', description: '')
aws_ses_template_html = input(:aws_ses_template_html, value: '', description: '')

control 'aws-ses-template-1.0' do
  impact 1.0
  title 'Test the properties of the ses receipt rules.'

  describe aws_ses_template(template_name: aws_ses_template_name) do
    it { should exist }
  end

  describe aws_ses_template(template_name: aws_ses_template_name) do
    its('template_name') { should eq aws_ses_template_name }
    its('subject_part') { should eq aws_ses_template_subject }
    its('text_part') { should eq aws_ses_template_text }
    its('html_part') { should eq aws_ses_template_html }
  end
end
