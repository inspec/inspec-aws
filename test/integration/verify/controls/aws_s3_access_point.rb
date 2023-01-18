title 'Test the properties of S3 Access Point'

skip_control 'aws-s3-access-point-1.0' do
  title 'Test the properties of S3 Access Point'

  describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
    it { should exist }
    its('id') { should eq 'MetricsId' }
    its('filter.access_point_arn') { should be_empty }
    its('filter.and.access_point_arn') { should eq 'ARN' }
  end
end
