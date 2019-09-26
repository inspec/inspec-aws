title 'Test a collection of AWS Queues'

arn = input(:aws_sqs_queue_arn, value: '', description: 'The AWS SQS Queue arn.')

control 'aws-sqs-queues-1.0' do
  impact 1.0
  title 'Ensure AWS SQS Queues plural resource has the correct properties.'

  describe aws_sqs_queues do
    it           { should exist }
    its ('arns') { should include arn}
  end
end
