aws_cloudfront_group_id = input(:aws_cloudfront_group_id, value: '', description: '')
aws_cloudfront_group_name = input(:aws_cloudfront_group_name, value: '(none)', description: '')

control 'aws-cloudfront-key-groups-1.0' do
  title 'Describes the AWS cloudfront keys group.'
  
  describe aws_cloudfront_key_groups do
    it { should exist }
    its('key_group_config_names') { should include aws_cloudfront_group_name }
    its('ids') { should include aws_cloudfront_group_id }
  end
end
