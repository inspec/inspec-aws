title 'Test the properties of S3 Access Point'

skip_control 'aws-s3-access-points-1.0' do
  title 'Test the properties of S3 Access Point'

  describe aws_s3_access_points(bucket_name: 'BucketName') do
    it { should exist }
    its('ids') { should include 'MetricsId' }
    its('filter_access_point_arns') { should_not be_empty }
    its('filter_and_access_point_arns') { should include 'ARN' }
  end
end
