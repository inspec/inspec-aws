aws_cloudfront_group_id = input(:aws_cloudfront_group_id, value: '', description: '')
aws_cloudfront_group_name = input(:aws_cloudfront_group_name, value: '(none)', description: '')
aws_cloudfront_group_comment = input(:aws_cloudfront_group_comment, value: '(none)', description: '')

control 'aws-cloudfront-public-key-1.0' do
  title 'Describes the AWS cloudfront keys group.'
  
  describe aws_cloudfront_key_group(id: aws_cloudfront_group_id) do
    it { should exist }
    its('id') { should eq aws_cloudfront_group_id }
    its('key_group_config.name') { should eq aws_cloudfront_group_name }
    its('key_group_config.comment') { should eq aws_cloudfront_group_comment }
  end
end
