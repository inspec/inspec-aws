aws_signer_signing_profile_name = input(:aws_signer_signing_profile_name, value: '', description: '')
aws_signer_signing_profile_platform_id = input(:aws_signer_signing_profile_platform_id, value: '', description: '')
aws_signer_signing_profile_status = input(:aws_signer_signing_profile_status, value: '', description: '')
aws_signer_signing_profile_version_arn = input(:aws_signer_signing_profile_version_arn, value: '', description: '')
aws_signer_signing_profile_version = input(:aws_signer_signing_profile_version, value: '', description: '')

control 'aws-signer-signing-profiles-1.0' do
  impact 1.0
  title 'Test the plural resource of the Signing Profile.'

  describe aws_signer_signing_profiles do
    it { should exist }
  end

  describe aws_signer_signing_profiles do
    its('profile_names') { should include aws_signer_signing_profile_name }
    its('profile_versions') { should include aws_signer_signing_profile_version }
    its('profile_version_arns') { should include aws_signer_signing_profile_version_arn }
    its('signing_materials') { should_not be_empty }
    its('platform_ids') { should include aws_signer_signing_profile_platform_id }
    its('platform_display_names') { should include 'AWS Lambda' }
    its('signature_validity_periods') { should_not be_empty }
    its('signing_parameters') { should_not be_empty }
    its('statuses') { should include aws_signer_signing_profile_status }
    its('arns') { should_not be_empty }
    its('tags') { should_not be_empty }
  end
end
