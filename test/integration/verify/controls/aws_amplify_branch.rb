app_id = input(:app_id, value: '', description: '')
branch_name = input(:branch_name, value: '', description: '')

title 'Ensure Amplify App have the correct properties.'

control 'aws_amplify_branch-1.0' do
  impact 1.0
  title 'Ensure Amplify App have the correct properties.'

  describe aws_amplify_branch(app_id: app_id, branch_name: branch_name) do
    it { should exist }
  end

  describe aws_amplify_branch(app_id: app_id, branch_name: branch_name) do
    its('count') { should >= 1 }
    its('branch_name') { should eq 'main' }
    its('display_name') { should eq 'test-name' }
  end
end

