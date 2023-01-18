title 'Test single Cloudfront distribution'

secure_distribution_id = input(:aws_secure_cloudfront_distribution_id, value: '', description: 'The secure AWS Cloudfront distribution ID.')
insecure_distribution_id = input(:aws_insecure_cloudfront_distribution_id, value: '', description: 'The insecure AWS Cloudfront distribution ID.')
default_distribution_id = input(:aws_default_cloudfront_distribution_id, value: '', description: 'The defaultinsecure AWS Cloudfront distribution ID.')

control 'aws-cloudfront-distribution-1.0' do
  title 'Ensure AWS Cloudfront distribution has the correct properties.'

  describe aws_cloudfront_distribution(distribution_id: secure_distribution_id) do
    it { should exist }
    it { should_not have_s3_origin_configs }
    %w{SSLv3 TLSv1}.each do |protocol|
      its('custom_origin_ssl_protocols') { should_not include protocol }
    end
    it { should_not have_disallowed_custom_origin_ssl_protocols }
    its('viewer_certificate_minimum_ssl_protocol') { should_not match /SSLv3|TLSv1$|TLSv1_2016/ }
    it { should_not have_disallowed_viewer_certificate_minimum_ssl_protocol }
    its('viewer_protocol_policies') { should_not include 'allow-all' }
    it { should_not have_viewer_protocol_policies_allowing_http }
  end

  describe aws_cloudfront_distribution(distribution_id: insecure_distribution_id,
                                       disallowed_ssl_protocols: %w{SSLv3 TLSv1 TLSv1_2016 TLSv1.2 TLSv1.2_2016}) do
    it { should exist }
    it { should_not have_s3_origin_configs }
    its('custom_origin_ssl_protocols') { should include 'SSLv3' }
    its('custom_origin_ssl_protocols') { should include 'TLSv1' }
    it { should have_disallowed_custom_origin_ssl_protocols }
    its('viewer_certificate_minimum_ssl_protocol') { should eq 'TLSv1' }
    it { should have_disallowed_viewer_certificate_minimum_ssl_protocol }
    its('viewer_protocol_policies') { should include 'allow-all' }
    it { should have_viewer_protocol_policies_allowing_http }
  end

  describe aws_cloudfront_distribution(distribution_id: default_distribution_id) do
    it { should exist }
    it { should have_s3_origin_configs }
    its('custom_origin_ssl_protocols') { should eq [] }
    it { should_not have_disallowed_custom_origin_ssl_protocols }
    its('viewer_certificate_minimum_ssl_protocol') { should eq 'TLSv1' }
    it { should have_disallowed_viewer_certificate_minimum_ssl_protocol }
    its('viewer_protocol_policies') { should include 'allow-all' }
    it { should have_viewer_protocol_policies_allowing_http }
  end

  describe aws_cloudfront_distribution(distribution_id: 'does-not-exist') do
    it { should_not exist }
  end
end
