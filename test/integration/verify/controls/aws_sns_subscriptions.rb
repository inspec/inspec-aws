describe aws_sns_subscriptions do
  it { should exist }
end

describe aws_sns_subscriptions do
  its('subscription_arns') { should include 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju:18fa3790-373a-4307-b6de-a7c5e1e48007' }
  its('owners') { should include '112758395563' }
  its('protocols') { should include 'sqs' }
  its('endpoints') { should include 'arn:aws:sqs:us-east-2:112758395563:test-ElasticSearch-s3' }
  its('topic_arns') { should include 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
end