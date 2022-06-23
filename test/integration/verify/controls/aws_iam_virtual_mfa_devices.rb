title 'Test single AWS IAM Virtual MFA Devices'

skip_control 'aws-iam-virtual-mfa-devices-1.0' do
  impact 1.0
  title 'Check AWS IAM Virtual MFA Devices has the correct properties.'

  describe aws_iam_virtual_mfa_devices do
    it { should exist }
    its('user_names') { should include 'test-iam' }
    its('arns') { should include 'test-iam' }
    its('user_ids') { should include 'test-iam' }
    its('paths') { should include '/' }
    its('create_dates') { should include Time.parse('2017-11-09 20:40:47.000000000 +0000') }
  end
end
