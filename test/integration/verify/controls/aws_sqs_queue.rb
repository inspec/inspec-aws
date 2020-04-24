title 'Test single AWS Queue'

arn = attribute(:aws_sqs_queue_arn, default: '', description: 'The AWS SQS Queue arn.')
if arn.empty?
  aws_sqs_queue_url = ""
else
  modified_arn = arn.dup
  modified_arn.slice!("arn:aws:sqs:")
  url = modified_arn.split(':', 2)
  aws_sqs_queue_url = ""
  aws_sqs_queue_url =  "https://sqs.#{url[0]}.amazonaws.com/#{url[1].sub(':','/')}" if url
end

control 'aws-sqs-queue-1.0' do
  impact 1.0
  title 'Ensure AWS SQS Queue has the correct properties.'

  describe aws_sqs_queue(queue_url: aws_sqs_queue_url) do
    it          { should exist }
    its ('arn') { should eq arn}
  end
end
