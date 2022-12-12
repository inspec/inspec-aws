title 'Test a collection of AWS Queues'

arn = input(:aws_sqs_queue_arn, value: '', description: 'The AWS SQS Queue arn.')
if arn.empty?
  aws_sqs_queue_url = ""
else
  modified_arn = arn.dup
  modified_arn.slice!("arn:aws:sqs:")
  url = modified_arn.split(':', 2)
  aws_sqs_queue_url = ""
  aws_sqs_queue_url =  "https://sqs.#{url[0]}.amazonaws.com/#{url[1].sub(':','/')}" if url
end

control 'aws-sqs-queues-1.0' do
  title 'Ensure AWS SQS Queues plural resource has the correct properties.'

  describe aws_sqs_queues do
    it           { should exist }
    its ('arns') { should include arn}
  end

  aws_regions.region_names.each do |region|
    aws_sqs_queues(aws_region: region).queue_urls.each do |queue_url|
      describe.one do
        describe aws_sqs_queue(aws_region: region, queue_url: queue_url) do
          it { should exist }
          its('kms_master_key_id') { should_not be_nil }
        end

        describe aws_sqs_queue(aws_region: region, queue_url: queue_url) do
          it { should exist }
          its('kms_master_key_id') { should be_nil }
        end
      end
    end
  end
end
