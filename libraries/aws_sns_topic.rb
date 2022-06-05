# frozen_string_literal: true

require 'aws_backend'

class AwsSnsTopic < AwsResourceBase
  name 'aws_sns_topic'
  desc 'Verifies settings for an SNS Topic.'
  example "
    describe aws_sns_topic('arn:aws:sns:us-east-1:123456789012:some-topic') do
      it { should exist }
      its('confirmed_subscription_count') { should_not be_zero }
      its('policy_actions') { should include 'SNS:Subscribe' }
    end
  "

  attr_reader :arn, :kms_master_key_id, :confirmed_subscription_count,
              :policy, :policy_statement_sid, :policy_statement_effect, :policy_statement_principal, :policy_statement_action, :policy_statement_condition

  def initialize(opts = {})
    opts = { arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:arn])
    raise ArgumentError, "#{@__resource_name__}: expected an ARN of the form arn:aws:sns:REGION:ACCOUNT-ID:TOPIC-NAME" if opts[:arn] !~ /^arn:aws:sns:[\w\-]+:\d{12}:[\S]+$/
    @arn = opts[:arn]
    catch_aws_errors do
      begin
        resp = @aws.sns_client.get_topic_attributes(topic_arn: @arn).attributes.to_h
        @confirmed_subscription_count = resp['SubscriptionsConfirmed'].to_i
        @kms_master_key_id = resp['KmsMasterKeyId']
        @policy = JSON.parse(resp['Policy'])['Statement'].to_s
        @policy_statement_sid = JSON.parse(resp['Policy'])['Statement'][0]['Sid']
        @policy_statement_effect = JSON.parse(resp['Policy'])['Statement'][0]['Effect']
        @policy_statement_principal = JSON.parse(resp['Policy'])['Statement'][0]['Principal'].to_s
        @policy_statement_action = JSON.parse(resp['Policy'])['Statement'][0]['Action']
        @policy_statement_condition = JSON.parse(resp['Policy'])['Statement'][0]['Condition'].to_s
        create_resource_methods(resp)
      rescue Aws::SNS::Errors::NotFound
        return
      end
    end
  end

  def exists?
    !@confirmed_subscription_count.nil?
  end

  def resource_id
    @arn
  end

  def to_s
    "SNS Topic ARN: #{@arn}"
  end
end
