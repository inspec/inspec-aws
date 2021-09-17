# frozen_string_literal: true

branch_name= attribute(branch_name, default: '', description: '')

title 'Amplify App'
control 'aws_amplify_branch-1.0' do
  impact 1.0
  title 'Ensure Amplify App have the correct properties.'
  describe aws_amplify_branch(branch_name: branch_name) do
    it { should exist }
    its('count') { should >= 1 }
    its('branch_name') { should eq 'main' }
    its('display_name') { should eq 'test-name' }
  end
end

