aws_signer_signing_profile_name = input(:aws_signer_signing_profile_name, value: '', description: '')
aws_signer_signing_profile_platform_id = input(:aws_signer_signing_profile_platform_id, value: '', description: '')
aws_signer_signing_profile_status = input(:aws_signer_signing_profile_status, value: '', description: '')
aws_signer_signing_profile_version_arn = input(:aws_signer_signing_profile_version_arn, value: '', description: '')
aws_signer_signing_profile_version = input(:aws_signer_signing_profile_version, value: '', description: '')

control 'aws-signer-signing-profile-1.0' do
  impact 1.0
  title 'Test the singular resource of the Signing Profile.'

  describe aws_signer_signing_profile(profile_name: aws_signer_signing_profile_name) do
    it { should exist }
  end

  describe aws_signer_signing_profile(profile_name: aws_signer_signing_profile_name) do
    its('profile_name') { should eq aws_signer_signing_profile_name }
    its('profile_version') { should eq aws_signer_signing_profile_version }
    its('profile_version_arn') { should eq aws_signer_signing_profile_version_arn }
    its('revocation_record.revocation_effective_from') { should be_empty }
    its('revocation_record.revoked_at') { should be_empty }
    its('revocation_record.revoked_by') { should be_empty }
    its('signing_material.certificate_arn') { should be_empty }
    its('platform_id') { should eq aws_signer_signing_profile_platform_id }
    its('platform_display_name') { should eq 'AWS Lambda' }
    its('signature_validity_period.value') { should eq 5 }
    its('signature_validity_period.type') { should eq 'YEARS' }
    its('overrides.signing_configuration.encryption_algorithm') { should be_empty }
    its('overrides.signing_configuration.hash_algorithm') { should be_empty }
    its('overrides.signing_image_format') { should be_empty }
    its('signing_parameters') { should be_empty }
    its('status') { should eq aws_signer_signing_profile_status }
    its('status_reason') { should be_empty }
    its('arn') { should_not be_empty }
  end

  describe aws_signer_signing_profile(profile_name: 'dummy') do
    it { should_not exist }
  end
end
