aws_cloudfront_cache_policy_id = input(:aws_cloudfront_cache_policy_id, value: '', description: '')

control 'aws-cloudfront-cache-policy' do
  title 'Ensure Cloudfront Cache Policy resource has the correct properties.'

  describe aws_cloudfront_cache_policy(id: aws_cloudfront_cache_policy_id) do
    it { should exist }
  end

  describe aws_cloudfront_cache_policy(id: aws_cloudfront_cache_policy_id) do
    its('id') { should eq aws_cloudfront_cache_policy_id }
  end

  describe aws_cloudfront_cache_policy(id: aws_cloudfront_cache_policy_id) do
    its('cache_policy_config.comment') { should eq 'test comment' }
    its('cache_policy_config.name') { should eq 'example-policy' }
    its('cache_policy_config.default_ttl') { should eq 50 }
    its('cache_policy_config.max_ttl') { should eq 100 }
    its('cache_policy_config.min_ttl') { should eq 1 }
  end

  describe aws_cloudfront_cache_policy(id: aws_cloudfront_cache_policy_id) do
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_gzip') { should eq false }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.enable_accept_encoding_brotli') { should eq false }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.header_behavior') { should eq 'whitelist' }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.headers.quantity') { should eq 1 }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.headers_config.headers.items') { should include 'example' }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookie_behavior') { should eq 'whitelist' }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookies.quantity') { should eq 1 }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.cookies_config.cookies.items') { should include 'example' }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_string_behavior') { should eq 'whitelist' }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_strings.quantity') { should eq 1 }
    its('cache_policy_config.parameters_in_cache_key_and_forwarded_to_origin.query_strings_config.query_strings.items') { should include 'example' }
  end
end
