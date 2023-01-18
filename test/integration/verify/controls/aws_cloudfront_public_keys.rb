aws_cloudfront_public_key_name = input(:aws_cloudfront_public_key_name, value: '', description: '')
aws_cloudfront_public_key_id = input(:aws_cloudfront_public_key_id, value: '', description: '')
aws_cloudfront_public_key = input(:aws_cloudfront_public_key, value: '', description: '')

control 'aws_cloudfront_public_keys-1.0' do
  title 'Describes the AWS cloudfront public keys.'

  describe aws_cloudfront_public_keys do
    it { should exist }
    its('names') { should include aws_cloudfront_public_key_name }
    its('ids') { should include aws_cloudfront_public_key_id }
    its('comments') { should include 'test public key'}
    its('public_key_config.encoded_key') { should include aws_cloudfront_public_key }
  end
end
