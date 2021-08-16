# frozen_string_literal: true
describe aws_iam_virtual_mfa_devices do
  it { should exist }
  its('user_names') { should include 'shaik-iam' }
  its('arns') { should include 'test-iam' }
  its('user_ids') { should include 'test-iam' }
  its('path') { should include '/' }
  its('create_date') { should include Time.parse('2017-11-09 20:40:47.000000000 +0000') }
end
