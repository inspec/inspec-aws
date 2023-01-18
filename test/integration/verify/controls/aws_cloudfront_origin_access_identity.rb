aws_cloudfront_origin_access_identity_id = input(:aws_cloudfront_origin_access_identity_id, value: '', description: '')
aws_cloudfront_origin_access_identity_s3_canonical_user_id = input(:aws_cloudfront_origin_access_identity_s3_canonical_user_id, value: '', description: '')
aws_cloudfront_origin_access_identity_caller_reference = input(:aws_cloudfront_origin_access_identity_caller_reference, value: '', description: '')

control 'aws-cloudfront-origin-access-identity' do
  title 'Ensure Cloud Front Origin Access Identity resource has the correct properties.'

  describe aws_cloudfront_origin_access_identity(id: aws_cloudfront_origin_access_identity_id) do
    it { should exist }
  end

  describe aws_cloudfront_origin_access_identity(id: aws_cloudfront_origin_access_identity_id) do
    its('id') { should eq aws_cloudfront_origin_access_identity_id }
    its('s3_canonical_user_id') { should eq aws_cloudfront_origin_access_identity_s3_canonical_user_id }
    its('cloud_front_origin_access_identity_config.caller_reference') { should eq aws_cloudfront_origin_access_identity_caller_reference }
    its('cloud_front_origin_access_identity_config.comment') { should eq 'Some comment' }
  end
end
