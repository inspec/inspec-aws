# frozen_string_literal: true

branch_name= attribute(branch_name, default: '', description: '')

title 'Amplify App'
control 'aws_amplify_branches-1.0' do
  impact 1.0
  title 'Ensure all Amplify App have the correct properties.'
  describe aws_amplify_branches do
    it { should exist }
    its('count') { should >= 1 }
    its('branch_names') { should include branch_name }
    its('display_names') { should include 'test-name' }
  end
end

