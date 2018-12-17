# frozen_string_literal: true

require 'aws_backend'

class AwsSnsSubscription < AwsResourceBase
  name 'aws_sns_subscription'
  desc 'Verifies settings for a SNS Subscription'
  example "
    describe aws_sns_subscription('arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6') do
      it { should_not have_raw_message_delivery }
      it { should be_confirmation_authenticated }
      its('owner') { should cmp '12345678' }
      its('topic_arn') { should cmp 'arn:aws:sns:us-east-1::test-topic-01' }
      its('endpoint') { should cmp 'arn:aws:sqs:us-east-1::test-queue-01' }
      its('protocol') { should cmp 'sqs' }
    end
  "

  attr_reader :arn, :owner, :raw_message_delivery, :topic_arn, :endpoint, :protocol,
              :confirmation_was_authenticated, :aws_response, :exists

  alias confirmation_authenticated? confirmation_was_authenticated
  alias raw_message_delivery? raw_message_delivery
  alias has_raw_message_delivery? raw_message_delivery
  alias exists? exists

  def initialize(opts = {})
    # Call the parent class constructor
    opts = { subscription_arn: opts } if opts.is_a?(String) # this preserves the original scalar interface
    super(opts)
    validate_parameters([:subscription_arn])
    @display_name = opts[:subscription_arn]
    catch_aws_errors do
      begin
        @aws_response = @aws.sns_client.get_subscription_attributes(subscription_arn: opts[:subscription_arn]).attributes.to_h
        @exists = true
        @owner = @aws_response['Owner']
        @raw_message_delivery = @aws_response['RawMessageDelivery'].eql?('true')
        @topic_arn = @aws_response['TopicArn']
        @endpoint = @aws_response['Endpoint']
        @protocol = @aws_response['Protocol']
        @confirmation_was_authenticated = @aws_response['ConfirmationWasAuthenticated'].eql?('true')
      rescue Aws::SNS::Errors::NotFound
        @exists = false
        return
      end
    end
  end

  def to_s
    "SNS Subscription #{@display_name}"
  end
end
