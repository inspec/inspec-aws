# frozen_string_literal: true
aws_cloudfront_group_id = attribute('aws_cloudfront_group_id', value: '', description: '')
aws_cloudfront_group_name = attribute('aws_cloudfront_group_name', value: '(none)', description: '')
aws_cloudfront_group_comment = attribute('aws_cloudfront_group_comment', value: '(none)', description: '')

control 'aws_cloudfront_public_key-1.0' do
  impact 1.0
  title 'Describes the AWS cloudfront keys group.'
  describe aws_cloudfront_key_group(id: aws_cloudfront_group_id) do
    it { should exist }
    its('id') { should eq aws_cloudfront_group_id }
    its('key_group_config.name') { should eq aws_cloudfront_group_name }
    its('key_group_config.comment') { should eq aws_cloudfront_group_comment }
  end
end
