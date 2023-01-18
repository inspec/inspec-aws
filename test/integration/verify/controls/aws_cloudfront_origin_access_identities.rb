aws_cloudfront_origin_access_identity_id = input(:aws_cloudfront_origin_access_identity_id, value: '', description: '')
aws_cloudfront_origin_access_identity_s3_canonical_user_id = input(:aws_cloudfront_origin_access_identity_s3_canonical_user_id, value: '', description: '')

control 'aws-cloudfront-origin-access-identities' do
  title 'Ensure Cloud Front Origin Access Identities resource has the correct properties.'

  describe aws_cloudfront_origin_access_identities do
    it { should exist }
  end

  describe aws_cloudfront_origin_access_identities do
    its('ids') { should include aws_cloudfront_origin_access_identity_id }
    its('s3_canonical_user_ids') { should include aws_cloudfront_origin_access_identity_s3_canonical_user_id }
    its('comments') { should include 'Some comment' }
  end
end
