require 'aws_backend'

class AwsShieldSubscription < AwsResourceBase
  name 'aws_shield_subscription'
  desc 'Verifies settings for a Shield Subscription.'
  example "
    describe aws_shield_subscription do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)

    catch_aws_errors do
      resp = @aws.shield_client.describe_subscription
      if resp.subscription.nil?
        empty_response_warn
      else
        @subscription = resp.subscription.to_h
        create_resource_methods(@subscription)
      end
    end
  end

  def exists?
    !failed_resource?
  end
end
