aws_cloudfront_distribution_id = input(:aws_cloudfront_distribution_id, value: '', description: '')
aws_cloudfront_distribution_arn = input(:aws_cloudfront_distribution_arn, value: '', description: '')
aws_cloudfront_distribution_status = input(:aws_cloudfront_distribution_status, value: '', description: '')

control 'aws-cloudfront-streaming-distributions-1.0' do
  impact 1.0
  title 'List CloudFront distributions.'

  describe aws_cloudfront_streaming_distributions do
    it { should exist }
  end

  describe aws_cloudfront_streaming_distributions do
    its('ids') { should include aws_cloudfront_distribution_id }
    its('arns') { should include aws_cloudfront_distribution_arn }
    its('statuses') { should include aws_cloudfront_distribution_status }
  end
end