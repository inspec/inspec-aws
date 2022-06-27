app_id = input(:app_id, value: '', description: '')

title 'Audits Amplify Apps.'

control 'aws_amplify_apps-1.0' do
  impact 1.0
  title 'Ensure all Amplify App have the correct properties.'
  
  describe aws_amplify_apps do
    it { should exist }
    its('count') { should >= 1 }
    its('app_id') { should include app_id }
    its('app_arn') { should_not include 'arn:aws:amplify:us-east-1:112758395563:apps/d2pdgpts4t82r' }
  end
end

