aws_cloudfront_distribution_id = input(:aws_cloudfront_distribution_id, value: '', description: '')
aws_cloudfront_distribution_arn = input(:aws_cloudfront_distribution_arn, value: '', description: '')
aws_cloudfront_distribution_status = input(:aws_cloudfront_distribution_status, value: '', description: '')

control 'aws-cloudfront-streaming-distribution-1.0' do
  impact 1.0
  title 'Get the information about a distribution.'

  describe aws_cloudfront_streaming_distribution(id: aws_cloudfront_distribution_id) do
    it { should exist }
  end

  describe aws_cloudfront_streaming_distribution(id: aws_cloudfront_distribution_id) do
    its('id') { should eq aws_cloudfront_distribution_id }
    its('arn') { should eq aws_cloudfront_distribution_arn }
    its('status') { should eq aws_cloudfront_distribution_status }
  end
end