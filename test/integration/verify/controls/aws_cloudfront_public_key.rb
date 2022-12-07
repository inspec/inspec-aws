aws_cloudfront_public_key_name = input(:aws_cloudfront_public_key_name, value: '', description: '')
aws_cloudfront_public_key_id = input(:aws_cloudfront_public_key_id, value: '', description: '')
aws_cloudfront_public_key = input(:aws_cloudfront_public_key, value: '', description: '')

control 'aws_cloudfront_public_key-1.0' do
  impact 1.0
  title 'Describes the AWS cloudfront public key.'
  
  describe aws_cloudfront_public_key(id: aws_cloudfront_public_key_id ) do
    it { should exist }
    its('id') { should eq aws_cloudfront_public_key_id }
    its('public_key_config.encoded_key') { should eq aws_cloudfront_public_key }
    its('public_key_config.comment') { should eq 'test public key' }
    its('public_key_config.name') { should eq aws_cloudfront_public_key_name }
  end
end