require 'aws_backend'

class AwsSnsTopic < AwsResourceBase
  name 'aws_sns_topic'
  desc 'Verifies settings for an SNS Topic.'
  example "
    describe aws_sns_topic('arn:aws:sns:us-east-1:123456789012:some-topic') do
      it { should exist }
      its('confirmed_subscription_count') { should_not be_zero }
    end
  "
  attr_reader :arn, :kms_master_key_id, :confirmed_subscription_count

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
    "SNS Topic #{@arn}"
  end
end
