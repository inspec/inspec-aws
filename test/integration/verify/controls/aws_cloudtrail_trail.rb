title 'Test single AWS CloudTrail'

aws_cloud_trail_name = attribute(:aws_cloud_trail_name, default: '', description: 'Cloud trail with encryption, key and logs.')
aws_cloud_trail_open_name = attribute(:aws_cloud_trail_open_name, default: '', description: 'Cloud trail only with bucket.')
aws_cloud_trail_bucket_id = attribute(:aws_cloud_trail_bucket_id, default: '', description: 'Cloud trail bucket.')
aws_cloud_trail_open_s3_bucket_id = attribute(:aws_cloud_trail_open_s3_bucket_id, default: '', description: 'Cloud trail bucket.')
aws_cloud_trail_arn = attribute(:aws_cloud_trail_arn, default: '', description: 'Cloud trail ARN.')
aws_cloud_trail_open_arn = attribute(:aws_cloud_trail_open_arn, default: '', description: 'Cloud trail ARN.')
aws_cloud_trail_key_arn = attribute(:aws_cloud_trail_key_arn, default: '', description: 'Cloud trail key ARN.')
aws_cloud_trail_cloud_watch_logs_group_arn = attribute(:aws_cloud_trail_cloud_watch_logs_group_arn, default: '', description: 'Cloud log group ARN.')
aws_cloud_trail_cloud_watch_logs_role_arn = attribute(:aws_cloud_trail_cloud_watch_logs_role_arn, default: '', description: 'Cloud log role ARN.')

control 'aws-cloudtrail-1.0' do

  impact 1.0
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
end