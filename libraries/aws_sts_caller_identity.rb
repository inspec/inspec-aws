# frozen_string_literal: true

class AwsStsCallerIdentity < AwsResourceBase
  name 'aws_sts_caller_identity'
  desc 'Verifies settings for an AWS STS Caller Identity'
  example '
    describe aws_sts_caller_identity do
      its("arn") { should match "arn:aws:iam::.*:user/service-account-inspec" }
    end

    describe aws_sts_caller_identity do
      it { should be_govcloud }
    end
  '

  attr_reader :arn

  def initialize(opts = {})
    super(opts)
    validate_parameters

    catch_aws_errors do
      @arn = @aws.sts_client.get_caller_identity.arn
    end
  end

  def govcloud?
    fetch_arn_components[:partition] == 'aws-us-gov'
  end

  def exists?
    !@arn.nil?
  end

  def to_s
    'AWS Security Token Service Caller Identity'
  end

  private

  def fetch_arn_components
    Hash[%i(arn partition service region account_id resource).zip(@arn.split(':'))]
  end
end
