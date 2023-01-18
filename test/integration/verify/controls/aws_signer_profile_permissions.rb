aws_signer_signing_profile_permission_action = input(:aws_signer_signing_profile_permission_action, value: '', description: '')
aws_signer_signing_profile_permission_profile_name = input(:aws_signer_signing_profile_permission_profile_name, value: '', description: '')
aws_signer_signing_profile_permission_principal = input(:aws_signer_signing_profile_permission_principal, value: '', description: '')
aws_signer_signing_profile_permission_statement_id = input(:aws_signer_signing_profile_permission_statement_id, value: '', description: '')

control 'aws_signer_profile_permissions-1.0' do
  title 'Test the properties of the ses receipt rules.'

  describe aws_signer_profile_permissions(profile_name: aws_signer_signing_profile_permission_profile_name) do
    it { should exist }
  end

  describe aws_signer_profile_permissions(profile_name: aws_signer_signing_profile_permission_profile_name) do
    its('actions') { should include aws_signer_signing_profile_permission_action }
    its('principals') { should include aws_signer_signing_profile_permission_principal }
    its('statement_ids') { should include aws_signer_signing_profile_permission_statement_id }
    its('profile_versions') { should_not be_empty }
  end

  describe aws_signer_profile_permissions(profile_name: 'dummy') do
    it { should_not exist }
  end
end
