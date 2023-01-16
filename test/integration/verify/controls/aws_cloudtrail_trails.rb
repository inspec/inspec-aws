title 'Test AWS VPCs in bulk'

aws_cloud_trail_arn = input(:aws_cloud_trail_arn, value: '', description: 'Cloud trail ARN.')
aws_cloud_trail_open_arn = input(:aws_cloud_trail_open_arn, value: '', description: 'Cloud trail ARN.')
aws_cloud_trail_name = input(:aws_cloud_trail_name, value: '', description: 'Cloud trail with encryption, key and logs.')
aws_cloud_trail_open_name = input(:aws_cloud_trail_open_name, value: '', description: 'Cloud trail only with bucket.')

control 'aws-cloudtrails-1.0' do
  title 'Ensure AWS Cloud Trail plural resource has the correct properties.'

  describe aws_cloudtrail_trails do
    it { should exist }
    its('count') { should be >= 2 }
    its('names') { should include aws_cloud_trail_name }
    its('names') { should include aws_cloud_trail_open_name }
    its('trail_arns') { should include aws_cloud_trail_arn }
    its('trail_arns') { should include aws_cloud_trail_open_arn }
  end
end
