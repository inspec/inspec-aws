secure_distribution_id = input(:aws_secure_cloudfront_distribution_id, value: '', description: 'The secure AWS Cloudfront distribution ID.')

title 'Test plural Cloudfront distributions.'

control 'aws-cloudfront-distributions-1.0' do
  title 'Ensure AWS Cloudfront distributions resource has the correct properties.'

  describe aws_cloudfront_distributions do
    it { should exist }
    its('distribution_ids') { should include secure_distribution_id }
    its('count') { should be >= 3 }
  end
end
