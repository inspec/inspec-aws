title 'Test single AWS CloudWatch Log Group'

aws_cloud_watch_log_group_name = input(:aws_cloud_watch_log_group_name, value: '', description: 'The AWS DHCP Options ID.')

control 'aws-cloudwatch-log-group-1.0' do
  title 'Ensure AWS Cloudwatch Log Group has the correct properties.'

  describe aws_cloudwatch_log_group(log_group_name:  aws_cloud_watch_log_group_name) do
    it { should exist }
    its('retention_in_days') { should eq 7 }
    its('kms_key_id') { should eq nil }
    its('tags') { should include('Name' => aws_cloud_watch_log_group_name)}
  end
end
