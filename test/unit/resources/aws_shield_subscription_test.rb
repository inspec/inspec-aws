require 'helper'
require 'aws_shield_subscription'
require 'aws-sdk-core'

class AwsShieldSubscriptionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_subscription
    mock_subscription = {}
    mock_subscription[:start_time] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_subscription[:end_time] = Time.parse("2014-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_subscription[:time_commitment_in_seconds] = 1000
    mock_subscription[:auto_renew] = 'ENABLED'
    mock_subscription[:limits] = [{ type: 'GLOBAL_ACCELERATOR',
                              max: 1000 }]
    mock_subscription[:subscription_limits] = {:protection_limits => {:protected_resource_type_limits => [{:max => 8, :type => "eni"}]}, :protection_group_limits => {:max_protection_groups => 8, :pattern_type_limits => {:arbitrary_pattern_limits => {:max_members => 4}}}}
    data[:data] = { subscription: mock_subscription }
    data[:client] = Aws::Shield::Client
    @subscription = AwsShieldSubscription.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subscription_exists
    assert @subscription.exists?
  end

  def test_subscription_start_time
    assert_equal(@subscription.start_time, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_subscription_end_time
    assert_equal(@subscription.end_time, Time.parse("2014-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_subscription_time_commitment
    assert_equal(@subscription.time_commitment_in_seconds, 1000)
  end

  def test_subscription_auto_renew
    assert_equal(@subscription.auto_renew, 'ENABLED')
  end
end
