require "aws_backend"

class AWSRDSEventSubscription < AwsResourceBase
  name "aws_rds_event_subscription"
  desc "Returns information about a RDS Event Subscription."

  example "
    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[subscription_name])
    unless opts[:subscription_name] && !opts[:subscription_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: subscription_name must be provided"
    end
    @display_name = opts[:subscription_name]
    catch_aws_errors do
      resp =
        @aws.rds_client.describe_event_subscriptions(
          { subscription_name: opts[:subscription_name] }
        )
      @res = resp.event_subscriptions_list[0].to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@res ? @res[:customer_aws_id] : ""}_#{@res ? @res[:cust_subscription_id] : ""}"
  end

  def subscription_name
    return nil unless exists?
    @res[:subscription_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "RDS Event Subscription Name: #{@display_name}"
  end
end
