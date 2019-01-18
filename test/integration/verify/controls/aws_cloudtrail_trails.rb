title 'Test AWS VPCs in bulk'

aws_cloud_trail_arn = attribute(:aws_cloud_trail_arn, default: '', description: 'Cloud trail ARN.')
aws_cloud_trail_open_arn = attribute(:aws_cloud_trail_open_arn, default: '', description: 'Cloud trail ARN.')
aws_cloud_trail_name = attribute(:aws_cloud_trail_name, default: '', description: 'Cloud trail with encryption, key and logs.')
aws_cloud_trail_open_name = attribute(:aws_cloud_trail_open_name, default: '', description: 'Cloud trail only with bucket.')

control 'aws-cloudtrails-1.0' do

  impact 1.0
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