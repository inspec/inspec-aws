title 'Test single AWS CloudTrail'

aws_cloud_trail_name = input(:aws_cloud_trail_name, value: '', description: 'Cloud trail with encryption, key and logs.')
aws_cloud_trail_open_name = input(:aws_cloud_trail_open_name, value: '', description: 'Cloud trail only with bucket.')
aws_cloud_trail_bucket_id = input(:aws_cloud_trail_bucket_id, value: '', description: 'Cloud trail bucket.')
aws_cloud_trail_open_s3_bucket_id = input(:aws_cloud_trail_open_s3_bucket_id, value: '', description: 'Cloud trail bucket.')
aws_cloud_trail_arn = input(:aws_cloud_trail_arn, value: '', description: 'Cloud trail ARN.')
aws_cloud_trail_open_arn = input(:aws_cloud_trail_open_arn, value: '', description: 'Cloud trail ARN.')
aws_cloud_trail_key_arn = input(:aws_cloud_trail_key_arn, value: '', description: 'Cloud trail key ARN.')
aws_cloud_trail_cloud_watch_logs_group_arn = input(:aws_cloud_trail_cloud_watch_logs_group_arn, value: '', description: 'Cloud log group ARN.')
aws_cloud_trail_cloud_watch_logs_role_arn = input(:aws_cloud_trail_cloud_watch_logs_role_arn, value: '', description: 'Cloud log role ARN.')

control 'aws-cloudtrail-1.0' do
  title 'Ensure AWS Cloud Trail has the correct properties.'

  describe aws_cloudtrail_trail(aws_cloud_trail_name) do
    it { should exist}
  end

  describe aws_cloudtrail_trail(trail_name: aws_cloud_trail_open_name) do
    it { should exist }
  end

  describe aws_cloudtrail_trail('not-there-trail') do
    it { should_not exist }
  end

  describe aws_cloudtrail_trail(trail_name: aws_cloud_trail_name) do
    it { should exist }
    it { should be_encrypted }
    it { should be_multi_region_trail }
    it { should be_log_file_validation_enabled }
    its('s3_bucket_name') { should eq aws_cloud_trail_bucket_id }
    its('trail_arn') { should eq aws_cloud_trail_arn }
    its('cloud_watch_logs_role_arn') { should eq aws_cloud_trail_cloud_watch_logs_role_arn }
    its('cloud_watch_logs_log_group_arn') { should eq aws_cloud_trail_cloud_watch_logs_group_arn }
    its('kms_key_id') { should eq aws_cloud_trail_key_arn }
    its('delivered_logs_days_ago') { should eq 0 }
  end

  describe aws_cloudtrail_trail(trail_name: aws_cloud_trail_open_name) do
    it { should exist }
    it { should_not be_encrypted }
    it { should_not be_multi_region_trail }
    it { should_not be_log_file_validation_enabled }
    its('s3_bucket_name') { should eq aws_cloud_trail_open_s3_bucket_id }
    its('trail_arn') { should eq aws_cloud_trail_open_arn }
    its('cloud_watch_logs_role_arn') { should be_nil }
    its('cloud_watch_logs_log_group_arn') { should be_nil}
    its('kms_key_id') { should be_nil }
  end

  describe aws_cloudtrail_trail(aws_cloud_trail_name) do
    its('s3_key_prefix') { should_not eq nil }
    its('is_organization_trail') { should eq false }
    it { should be_organization_trail }
  end
end
